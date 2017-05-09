require 'pp'

class Initial

	def read
		@line1arr = gets.chomp.split(' ')
	end
	
	def show
		print @line1arr[0][0] + '.' + @line1arr[1][0]
	end

end

initial = Initial.new
initial.read
initial.show