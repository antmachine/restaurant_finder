# This moduel illustrates how additional functionality can be
# included (mixed in) to a class and then reused.
# Borrows heavily from Ruby on Rails' number_to_currency method.

module NumberHelper

	def number_to_currency(number, options={})
		unit      = options[:unit]      || '$'
		precision = options[:precision] || 2
		delimiter = options[:delimiter] || ','
		separator = options[:separator] || '.'
	

		separator = '' if precision == 0
		integer, decimal = number.to_s.split(".")

		i = integer.length
		until i <= 3
			i -= 3
			integer = integer.insert(i,delimiter)
		end
#a way to ensure only one '$'' is added to the price in listing
		if unit == '$'
			unit = ''
		else
			unit = '$'
		end

		if precision == 0
			precise_decimal = ''
		else
			decimal ||= "0"
			decimal = decimal[0, precision-1]
			precise_decimal = decimal.ljust(precision, '0')
		end

		return unit + integer + separator + precise_decimal
	end
end