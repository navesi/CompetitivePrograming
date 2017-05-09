require 'pp'

class ChatLog
	
	def read
		line1Arr = gets.chomp.split(' ')
		@staffNum = line1Arr[0].to_i
		groupNum = line1Arr[1].to_i
		messageNum = line1Arr[2].to_i

		@groupDatas = []
		for i in 1..(groupNum)
			lineGroup = gets.chomp.split(' ')
			memberNum = lineGroup.shift	
			@groupDatas.push( { member: lineGroup, id: i.to_s, memberNum: memberNum.to_i } )
		end
		# pp @groupDatas
		@messageDatas = []
		for j in 0..(messageNum - 1)
			lineMessage = gets.chomp.split(' ')

			@messageDatas.push ({ owner: lineMessage[0],
												 type: lineMessage[1],
												 target: lineMessage[2],
												 content: lineMessage[3],
													id: j })
		end

		# pp @messageDatas
	end

	def show
		for i in 1..@staffNum
			# groupArr = getGroup i
			# pp i
			result = playMessageLog i#, groupArr
			result.each do |content|
				print content
				print "\n"
			end
			next if i == @staffNum
			print "--\n"
		end
		# line = gets
	end

	def playMessageLog staffId
		result = []
		groupIds = getGroupIds staffId

		@messageDatas.each do |message|
			if rightToShow staffId, message, groupIds
				result.push message[:content]
			end
		end
		return result
	end

	#めっせーじおーなーも
	def rightToShow staffId, message, groupIds
		result = false
		case message[:type]
		when "0" then #personal
			if staffId.to_s == message[:target] ||
				staffId.to_s == message[:owner]
					result = true
			end
		when "1" then #group
			# pp groupIds
			# pp message[:target]
			if groupIds.include?(message[:target]) ||
				 staffId.to_s == message[:owner]
				result = true
			end
		end
		return result
	end

	def getGroupIds staffId
		result = []
		@groupDatas.each do |group|
			if (group[:member].include?(staffId.to_s))
				result.push group[:id]
			end
		end
		return result
	end

end

chatLog = ChatLog.new
chatLog.read
chatLog.show