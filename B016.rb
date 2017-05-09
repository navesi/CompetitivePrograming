require 'pp'

class Place
	def read
		line1arr = gets.chomp.split(' ')
		@width = line1arr[0].to_i
		@height = line1arr[1].to_i
		logNum = line1arr[2].to_i

		line2arr = gets.chomp.split(' ')
		@currentX = line2arr[0].to_i
		@currentY = line2arr[1].to_i
		# i = 0
		@logs = Array.new
		for num in 1..logNum do
			lineOver3arr = gets.chomp.split(' ')
			pos = num - 1
			@logs[pos] = {:direction => lineOver3arr[0],
				:length => lineOver3arr[1].to_i}
		end
	end

	def showEndPosition
		@logs.each do |log|
			updateWithLog log
		end

		print @currentX.to_s + " " + @currentY.to_s
	end

	def updateWithLog log

		case log[:direction] 
		when "U" then
			moveUp log[:length]
		when "D" then
			moveDown log[:length]
		when "R" then
			moveRight log[:length]
		when "L" then
			moveLeft log[:length]
		else

		end # eo case

	end

	def moveUp length
		# 3 -4 

		@currentY = (@currentY + length) % @height	

	end

	def moveDown length
			@currentY =(@currentY - length) % @height
	end

	def moveRight length
			@currentX = (@currentX + length) % @width
	end

	def moveLeft length

			@currentX =(@currentX - length) % @width

	end

	def printCurrentPos
		p @currentX.to_s + ' ' + @currentY.to_s
	end

end

p = Place.new
p.read
p.showEndPosition