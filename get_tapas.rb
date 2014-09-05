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
  begin
    Dir::mkdir dirname unless File.exist? dirname
    File.open(filename, 'wb') do |fo|
      puts "#{url} ==> #{filename}"
      fo.write open(url).read
    end unless File.file? filename
    theDay = theDay.next
  rescue => e
    if (e.to_s.include? "404")
      puts "ERROR - Not found #{filename} - #{e}"
      theDay = theDay.next
    else
      sleeping = (1..10).to_a.sample
      puts "ERROR - retrying #{filename} in #{sleeping} secs - #{e}"
      File.delete filename if File.file? filename
      sleep sleeping
    end
  end
end
