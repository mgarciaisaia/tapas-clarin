#!/usr/bin/env ruby
require 'date'
require 'open-uri'
require 'fileutils'

theDay = Date.new(1945, 8, 29)
today = Date.today

while(theDay <= today) do
  dirname = theDay.strftime("%Y")
  filename = theDay.strftime("%Y/%Y%m%d.jpg")
  url = theDay.strftime("http://tapas.clarin.com/tapa/%Y/%m/%d/%Y%m%d.jpg")
  Dir::mkdir dirname unless File.exist? dirname
  File.open(filename, 'wb') do |fo|
    fo.write open(url).read
    sleeping = (1..10).to_a.sample
    puts "#{url} ==> #{filename} (sleeping #{sleeping})"
    sleep sleeping
  end unless File.file? filename
  theDay = theDay.next
end
