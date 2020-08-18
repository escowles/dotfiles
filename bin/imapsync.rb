#!/usr/bin/env ruby

# imapsync.rb - sync messages from one imap server to another
#
# configuration goes in ~/.imapsync/config.yml, which should look like:
#
# source:
#   host: mail.example.com
#   user: user@example.com
#   pass: XXXXXXXXXXXX
#   mbox: From Mailbox
# destination:
#   host: mail.example.org
#   user: user
#   pass: XXXXXXXXXXXX
#   mbox: Archive.<%= Date.today.year %>.<%= Date.today.strftime("%m") %>
#
# messages from the source server/mbox will be copied to the destination server/mbox
# (without duplication). All values can contain ERB interpolation, including Dates.
#
# TODO: could reorg this to have as many source/destination pairs as desired, which
# could look like:
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

# requirements: net/imap, plus yaml/erb/date for config
require "date"
require "erb"
require "net/imap"
require "yaml"

# check if a message with the given msg_id exists in the given imap server
def exists?(imap, msg_id)
  imap.search(["HEADER", "Message-ID", msg_id]).any?
end

# load configuration from yaml file
config = YAML.load(ERB.new(File.read("#{ENV["HOME"]}/.imapsync/config.yml")).result)
src_email = config["source"]["user"]
src_host = config["source"]["host"]
src_pass = config["source"]["pass"]
src_mbox = config["source"]["mbox"]
dst_email = config["destination"]["user"]
dst_host = config["destination"]["host"]
dst_pass = config["destination"]["pass"]
dst_mbox = config["destination"]["mbox"]

# connect to source imap and login
src_imap = Net::IMAP.new(src_host, 993, true)
src_imap.login(src_email, src_pass)

# connect to destination
dst_imap = Net::IMAP.new(dst_host, 993, true)
dst_imap.login(dst_email, dst_pass)

# open or create destination mailbox
unless dst_imap.list("", dst_mbox)
  puts "creating destination: #{dst_mbox}"
  dst_imap.create(dst_mbox)
end
dst_imap.select(dst_mbox)

# select source mbox, list messages, and copy messages that don't already exist to
# destination mbox
skip = 0
copy = 0
stat = src_imap.examine(src_mbox)
src_imap.search(["TO", "*"]).each do |message_id|
  msg = src_imap.fetch(message_id, ["ENVELOPE", "RFC822", "FLAGS", "INTERNALDATE"]).first
  msg_id = msg.attr['ENVELOPE'].message_id
  if exists?(dst_imap, msg_id)
    skip += 1
    puts "#{copy}/#{skip} skip #{msg_id}"
  else
    copy += 1
    puts "#{copy}/#{skip} copy #{msg_id}"
    dst_imap.append(dst_mbox, msg.attr['RFC822'], msg.attr['FLAGS'], msg.attr['INTERNALDATE'])
  end
end

# logout
src_imap.logout
src_imap.disconnect
dst_imap.logout
dst_imap.disconnect
