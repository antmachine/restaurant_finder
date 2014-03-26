require 'support/number_helper'

class Restaurant
	include NumberHelper

	@@filepath = nil
	# setter method to allow us to call the variable from outside the class
	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)
	end

	attr_accessor :name, :cuisine, :price

	# Here's a cleaner way of checking the usability of the file rather than a bunch of if/ else statements
	def self.file_usable?
		@@filepath && File.exists?(@@filepath) && File.readable?(@@filepath) && File.writable?(@@filepath)
	end

	def self.create_file
		File.open(@@filepath, 'w') unless file_usable?
		return file_usable?
	end

	def self.saved_restaurants
		restaurants = []
		if file_usable?
			file = File.new(@@filepath, 'r')
			file.each_line do |line|
				restaurants << Restaurant.new.import_line(line.chomp)
			end
			file.close
		end
		return restaurants
	end

	def self.build_using_questions
		args = {}
		print "Restaurant name:"
		args[:name] = gets.chomp.strip

		print "Cuisine type:"
		args[:cuisine] = gets.chomp.strip

		print "Average price:"
		args[:price] = gets.chomp.strip

		return self.new(args)
	end

	def initialize(args={})
		@name    = args[:name]    || ""
		@cuisine = args[:cuisine] || ""
		@price   = args[:price]   || ""
	end

	def import_line(line)
		line_array = line.split("\t")
		@name, @cuisine, @price = line_array
		return self
	end


	#need to add something that validates user input before passing to initialize
	#something to check for all 3 (name, price, cuisine) are present
	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath, 'a') do |file|
			file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
		end
		return true
	end

	def formatted_price
		number_to_currency(@price)
	end

end