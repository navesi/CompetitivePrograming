class WhichDoYouLike

	def read
		@num = gets.chomp.to_i
	end
	
	def choose
		result = 21 % @num 
		if result == 0
			result = @num 
		end
		return result
	end

	def show 
		result = choose
		print result
	end
end

wdyl = WhichDoYouLike.new
wdyl.read
wdyl.show