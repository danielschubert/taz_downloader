#!/usr/bin/env ruby

require 'uri'
require 'net/https'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
def dl(uri) 
  page = Nokogiri::HTML(open(uri))   
  file = page.xpath('//option/@value').first.value
  
  http = Net::HTTP.new(uri.host, 443)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  data = URI.encode_www_form({'password' => 'YOUR_PASSWORD', 'name' => 'YOUR_USERNAME', 'Laden' => 'Laden', 'id'=>file})

  File.open(file , 'w') {|f|
    http.post(uri.path, data) do |str|
      f.write str
    end
  }
end

uri = URI('https://dl.taz.de/pdf')
dl(uri)
