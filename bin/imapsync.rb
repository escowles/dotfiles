#!/usr/bin/env ruby

# imapsync.rb - sync messages from one imap server to another
#
# configuration goes in ~/.imapsync/config.yml, which should look like:
#
# servers:
#   server1:
#      host: mail.example.com
#      user: user@example.com
#      pass: XXXXXXXXXXXX
#   server2:
#      host: mail.example.org
#      user: user@example.org
#   server3:
#      host: mail.example.edu
#      user: user@example.edu
#      pass: XXXXXXXXXXXX
# sync:
#   profile1:
#     from_server: server1
#     from_mbox: From Mailbox
#     to_server: server2
#     to_mbox: Archive.<%= Date.today.year %>
#   profile2:
#      from_server: server2
#      from_mbox: Sent Messages
#      to_server: server3
#      to_mbox: sent
#
# for each sync entry, messages from the "from" server/mbox will be copied to the "to"
# server/mbox (without duplication). All values can contain ERB interpolation,
# including Dates.

# requirements: net/imap, plus yaml/erb/date for config
require "date"
require "erb"
require "net/imap"
require "yaml"

@connection_pool = {}

# check if a message with the given msg_id exists in the given imap server
def exists?(imap, msg_id)
  imap.search(["HEADER", "Message-ID", msg_id]).any?
end

# load a connection from the pool, or connect to the server
def get_connection(profile)
  return @connection_pool[profile] if @connection_pool[profile]

  props = @config["servers"][profile]
  con = Net::IMAP.new(props["host"], 993, true)
  con.login(props["user"], props["pass"])
  @connection_pool[profile] = con
  con
end

# load configuration from yaml file
@config = YAML.load(ERB.new(File.read("#{ENV["HOME"]}/.imapsync/config.yml")).result)

# iterate over each sync profile and copy messages
@config["sync"].each do |name, props|
  # connect to servers
  src_imap = get_connection(props["from_server"])
  dst_imap = get_connection(props["to_server"])

  # open or create destination mailbox
  dst_mbox = props["to_mbox"]
  unless dst_imap.list("", dst_mbox)
    puts "creating destination: #{dst_mbox}"
    dst_imap.create(dst_mbox)
  end
  dst_imap.select(dst_mbox)

  # select source mbox, list messages, and copy messages that don't already exist to
  # destination mbox
  skip = 0
  copy = 0
  stat = src_imap.examine(props["from_mbox"])
  src_imap.search(["TO", "*"]).each do |message_id|
    msg = src_imap.fetch(message_id, ["ENVELOPE", "RFC822", "FLAGS", "INTERNALDATE"]).first
    msg_id = msg.attr['ENVELOPE'].message_id
    if exists?(dst_imap, msg_id)
      skip += 1
      puts "#{name} #{copy}/#{skip} skip #{msg_id}"
    else
      copy += 1
      puts "#{name} #{copy}/#{skip} copy #{msg_id}"
      dst_imap.append(dst_mbox, msg.attr['RFC822'], msg.attr['FLAGS'], msg.attr['INTERNALDATE'])
    end
  end
end

# logout of all connected servers
@connection_pool.each do |_name, con|
  con.logout
  con.disconnect
end
