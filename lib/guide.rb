require 'restaurant'
require 'support/string_extend'
class Guide

	class Config
		@@actions = ['list', 'find', 'add', 'quit']
		def self.actions; @@actions; end
	end

	#initialize the Guide and provide a path that can be used for various purposes
	def initialize(path=nil)
		# locate the restaurant text file at path
		Restaurant.filepath = path
		if Restaurant.file_usable?
			puts "Found restaurant file."
		# or create a new file
		elsif Restaurant.create_file
			puts "Created restaurant file."
			
		# exit if create path fails
		else
			puts "Exiting.\n\n"
			exit!
		end
	end


	#this method will run the program
	def launch!
		introduction
		result = nil
		until result == :quit
			action = get_action
			result = do_action(action)
		end
		conclusion
	end

	def get_action
		action = nil
		# Keep asking for input from user until a valid action is given
		until Guide::Config.actions.include?(action)
			puts "Actions: " + Guide::Config.actions.join(", ") if action
			print ">"
			user_response = gets.chomp
			args = user_response.downcase.strip.split(' ')
			action = args.shift
		end
		return action, args
	end


	def do_action(action)
		case action
		when 'list'
			list
		when 'find'
			find
		when 'add'
			add
		when 'quit'
			return :quit
		else
			puts "\nCommand not found.\n"
		end
	end

	def list
		output_action_header("Listing restaurants")
		restaurants = Restaurant.saved_restaurants
		output_restaurant_table(restaurants)
	end

	def find(keyword="")
		output_action_header("Find a restaurant")
	end

	def add
		output_action_header("Add a restaurant")
		restaurant = Restaurant.build_using_questions
		if restaurant.save
			puts "\nRestaurant added\n\n"
		else
			puts "\nSave Error: Restaurant not added\n\n"
		end
	end

	def introduction
		puts "\n\n<<<  Welcome to Anthony's Food Finder  >>>\n\n"
		puts "This is an interactive program to help you find your next meal.\n\n"
	end

	def conclusion
		puts "\n<<<  Thank you and Happy Nom Noms!  >>>\n\n"
	end

	private

	def output_action_header(text)
		puts "\n#{text.upcase.center(60)}\n\n"
	end

	def output_restaurant_table(restaurants=[])
		print " " + "Name".ljust(30)
		print " " + "Cuisine".ljust(20)
		print " " + "Price".rjust(6) + "\n"
		puts "-" * 60
		restaurants.each do |rest|
			line = " " << rest.name.titleize.ljust(30)
			line << " " + rest.cuisine.titleize.ljust(20)
			line << " " + rest.formatted_price.titleize.rjust(6)
			puts line
		end
		puts "No listings found" if restaurants.empty?
		puts "-" * 60
	end

end