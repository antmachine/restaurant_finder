# This helper is opening up core Ruby String class
# in order to add a new method to all strings

class String

	def titleize
		self.split(' ').collect {|word| word.capitalize}.join(" ")
	end
end