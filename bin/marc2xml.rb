#!/usr/bin/env ruby

require "marc"

filename = ARGV[0]
reader = MARC::Reader.new(filename, external_encoding: "UTF-8")
writer = MARC::XMLWriter.new("#{filename}.xml")
reader.each do |record|
  writer.write(record)
end
writer.close()
