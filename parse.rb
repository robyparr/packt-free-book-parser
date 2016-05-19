#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rmagick'

# Page URL to parse
PAGE_URL = 'https://www.packtpub.com/packt/offers/free-learning'
TEMP_BOOK_IMG = "tmp_book_img.jpg"

# Get the page
puts "Parsing #{PAGE_URL}..."
page = Nokogiri::HTML(open(PAGE_URL))

# Get the book information
book_title = page.css('.dotd-title > h2').text
book_title.strip!

book_image = page.css('.bookimage')[0]['src']
open("https:#{book_image}") do |img|
	File.open(TEMP_BOOK_IMG, "wb") do |file|
		file.puts img.read
	end
end

# Output info
puts "Title: #{book_title}"

image = Magick::Image.read(TEMP_BOOK_IMG)

File.delete(TEMP_BOOK_IMG)

image[0].display
