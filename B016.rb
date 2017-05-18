require 'pp'

# Map上に居るヒーローの位置をログから読み取る
class HeroPositionManager

	def create
		load
	end

	def read
		updateHeroPositionWithAllLog
		showCurrentHeroPos
	end

	# 標準入力から取る
	def load
		line1arr = gets.chomp.split(' ')
		@mapWidth = line1arr[0].to_i
		@mapHeight = line1arr[1].to_i
		logNum = line1arr[2].to_i

		line2arr = gets.chomp.split(' ')
		@heroPos = {:x =>line2arr[0].to_i,
			:y =>line2arr[1].to_i}

		@logs = Array.new
		for num in 1..logNum do
			lineOver3arr = gets.chomp.split(' ')
			pos = num - 1
			@logs[pos] = {:direction => lineOver3arr[0],
				:length => lineOver3arr[1].to_i}
		end
	end

	# ログから
	def updateHeroPositionWithAllLog
		@logs.each do |log|
			updatePositionWithLog(log)
		end
	end

	# ログから新しいポジションに更新する
	# @param [Hash] 方向と長さのログ
	def updatePositionWithLog(log)
		case log[:direction]
		when "U" then
			updateHeroPositionUp(log[:length])
		when "D" then
			updateHeroPositionDown(log[:length])
		when "R" then
			updateHeroPositionRight(log[:length])
		when "L" then
			updateHeroPositionLeft(log[:length])
		# else
		end # eo case
	end

	def updateHeroPositionUp(length)
		@heroPos[:y] = (@heroPos[:y] + length) % @mapHeight
	end

	def updateHeroPositionDown(length)
		@heroPos[:y] = (@heroPos[:y] - length) % @mapHeight
	end

	def updateHeroPositionRight(length)
		@heroPos[:x] = (@heroPos[:x] + length) % @mapWidth
	end

	def updateHeroPositionLeft(length)
		@heroPos[:x] = (@heroPos[:x] - length) % @mapWidth
	end

	def showCurrentHeroPos
		p @heroPos[:x].to_s + ' ' + @heroPos[:y].to_s
	end
end

p = HeroPositionManager.new
p.create
p.read
