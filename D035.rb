require 'pp'

class PaizaDate

	def read()
			input_arr = gets.chomp.split(' ')
			@date = Hash.new
			@date[:year] = input_arr[0]
			@date[:month] = input_arr[1]
			@date[:day] = input_arr[2]
	end

	def show()

			print @date[:year] + "/" + @date[:month] + "/" + @date[:day]

	end

end

t = PaizaDate.new
t.read()
t.show()
