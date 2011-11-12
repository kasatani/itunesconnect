#!/usr/bin/env ruby
# Converts Payments page into a TSV file.
# Manually navigate to the page in the browser, 
# save the HTML into a local disk and run this script against the file.

require 'nokogiri'

doc = Nokogiri::HTML(open(ARGV[0]))

doc.css(".earnings-container").each do |c|
  title = c.css("h2").text.gsub(/\s+/, " ")
  if title =~ /Earned (\w+ \d+)/
    month = $1
    c.css(".earnings-matrix").each do |table|
      table.css("tr").each do |tr|
        if tr["class"] != "labels"
          row = tr.css("td").map{|td|td.text.strip}
          row.unshift(month)
          puts row.join("\t")
        end
      end
    end
  else
    raise "unrecognized title: #{title}"
  end
#  p c
end
