require 'pp'
class Eel
	def read
		# #ブロックの長さ2d+1のd ,うなぎを操作する回数 n
		line1Arr = gets.chomp.split(' ')
		@d = line1Arr[0].to_i
		@num = line1Arr[1].to_i

		@command = []
		for i in 0..(@num - 1)

			@command[i] = {num:gets.chomp.to_i}

		end


	end

	def show

	end

	def fetch
		@command.max_by(&:num)
	end

	def fetchMax
		result = {max: 0, position: 0}
		# result[:max] = 0
		# result[:position] = i
		for i in 0..(@command.count - 1)
			if result[:max] <= @command[i][:num]
				result[:max]= @command[i][:num]
				result[:position] = i
			end

		end

		@command[i][:direction] = "R"
		return result
	end

	def afterMax max, position
		currentX = max
		for i in position..(@command.count - 1)
			if(currentX < @command[i][:num])
				currentX -@command[i][:num]
			@command[i][:direction] = "R"
			@command[i][:direction] = "L"
		end
	end
end

eel = Eel.new
eel.read
result = eel.fetchMax
pp result
eel.afterMax result[:max], result[:position]

eel.show
