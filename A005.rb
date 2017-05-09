require 'pp'

class PaizaBawl
	def read
		line1Arr = gets.chomp.split(' ')
		@frameNum = line1Arr[0].to_i
		@pinNum = line1Arr[1].to_i
		@throwNum = line1Arr[2].to_i

		line2Arr = gets.chomp.split(' ')
		# {:frameNum, :scoreFirst, :scoreSecond, :scoreThird, :scoreTotal}
		@gameLog = createGameLog(line2Arr)
	end

	def show
		# if @gameLog[:scoreTotal] >= 0
			gameScore = getGameScore
			print gameScore
		# end
	end

	def createGameLog line2Arr
		result = []
		for i in 1..(@frameNum-1)
			#first
			score = line2Arr.shift

			if isItMaxPin score 
				result.push ({:scoreFirst => score})
				next
			end

			score2 = line2Arr.shift
			result.push({:scoreFirst => score, :scoreSecond => score2})

		end# for

		case line2Arr.length
		when 3 then

			result.push({:scoreFirst => line2Arr.shift, 
				:scoreSecond => line2Arr.shift,
				:scoreThird => line2Arr.shift})
		when 2 then
				result.push({:scoreFirst => line2Arr.shift, 
				:scoreSecond => line2Arr.shift})
		end


		return result
	end

	def updateGameLogTotal
		for i in 0..(@frameNum-3)
			totalScore = getTotalScore @gameLog[i], @gameLog[i+1], @gameLog[i+2]
			@gameLog[i][:scoreTotal ] = totalScore
		end

		totalScore = getTotalScoreSemiLast @gameLog[@frameNum - 2],
									 @gameLog[@frameNum - 1]
		@gameLog[@frameNum - 2][:scoreTotal] = totalScore

		#
		totalScore = getTotalScoreLast @gameLog[@frameNum - 1]
		@gameLog[@frameNum - 1][:scoreTotal]= totalScore


	end

	def isItMaxPin score
		result = false
		unless score == "G"
			if score.to_i == @pinNum
				result = true
			end
		end
		return result
	end

	def getGameScore
		result = 0
		@gameLog.each do |log|
			result += log[:scoreTotal]
		end
		return result
	end

	def getTotalScore score, score2, score3
		result = 0

		if isStrike score then
			result = convScore score[:scoreFirst]
			result += convScore score2[:scoreFirst]
			if score2[:scoreSecond]
				result += convScore score2[:scoreSecond]
			else
				result += convScore score3[:scoreFirst]
			end

		elsif isSpare score then
			result = convScore score[:scoreFirst]
			result += convScore score[:scoreSecond]
			result += convScore score2[:scoreFirst]
		else
			result = convScore score[:scoreFirst]
			# if score[:scoreSecond]
			result += convScore score[:scoreSecond]
			# end
		end

		return result
	end

	def getTotalScoreSemiLast score, score2
		result = 0

		if isStrike score then
			result = convScore score[:scoreFirst]
			result += convScore score2[:scoreFirst]
			result += convScore score2[:scoreSecond]

		elsif isSpare score then
			result = convScore score[:scoreFirst]
			result += convScore score[:scoreSecond]
			result += convScore score2[:scoreFirst]
		else
			result = convScore score[:scoreFirst]
			# if score[:scoreSecond]
			result += convScore score[:scoreSecond]
			# end
		end

		return result
	end

	def getTotalScoreLast score

				result = 0

		if isStrike score then
			result = convScore score[:scoreFirst]
			result += convScore score[:scoreSecond]
			result += convScore score[:scoreThird]

			result += convScore score[:scoreSecond]
			result += convScore score[:scoreThird]

			if isItMaxPin score[:scoreSecond]
				result += convScore score[:scoreThird] 
			end

		elsif isSpare score then
			result = convScore score[:scoreFirst]
			result += convScore score[:scoreSecond]
			result += convScore score[:scoreThird]
			result += convScore score[:scoreThird]#bonus

		else
			result = convScore score[:scoreFirst]
			# if score[:scoreSecond]
			result += convScore score[:scoreSecond]
			# end
		end

		return result
	end

	def isStrike score
		result = false
		return result if score[:scoreFirst] == "G"
		result = true if score[:scoreFirst].to_i == @pinNum

		return result
	end

	def isSpare score
# Dont mind when strike
		result = false
		total = convScore score[:scoreFirst]
		total += convScore score[:scoreSecond]
		result = true if total == @pinNum

		return result
	end

	def convScore string
		result = 0
		unless string == "G"
			result = string.to_i
		end
		return result
	end


end

pb = PaizaBawl.new
pb.read
pb.updateGameLogTotal
pb.show
