#!/usr/bin/env ruby
require 'date'
require 'open-uri'

theDay = Date.new(1945, 8, 29)
today = Date.today

while(theDay <= today) do
  filename = theDay.strftime("%Y/%Y%m%d.jpg")
  url = theDay.strftime("http://tapas.clarin.com/tapa/%Y/%m/%d/%Y%m%d.jpg")
  File.open(filename, 'wb') do |fo|
    fo.write open(url).read
  end
  puts "#{url} ==> #{filename}"
  theDay = theDay.next
end
