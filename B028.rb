require 'pp'

# チャットツール。送る対象としてグループか個人の2種類を選べる
class ChatMessageManager

	def create
		load
	end

	def read
		show
	end

	# データを標準入力から読み込み、それぞれ対応した各パラメータに置いていく
	def load
		line1Arr = gets.chomp.split(' ')
		@staffNum = line1Arr[0].to_i
		groupNum = line1Arr[1].to_i
		messageNum = line1Arr[2].to_i
		@groupDatas = []
		for i in 1..(groupNum)
			lineGroup = gets.chomp.split(' ')
			memberNum = lineGroup.shift
			@groupDatas.push( { member: lineGroup,
				id: i.to_s,
				memberNum: memberNum.to_i
			})
		end
		@messageDatas = []
		for j in 0..(messageNum - 1)
			lineMessage = gets.chomp.split(' ')
			@messageDatas.push ({ owner: lineMessage[0],
				type: lineMessage[1],
				target: lineMessage[2],
				content: lineMessage[3],
				id: j
				})
		end
	end

	# 指定のフォーマットに合わせた表示
	# スタッフの画面は順番に表示され--で区切られる
	def show
		for i in 1..@staffNum
			result = getMessageLogsFromId(i)
			result.each do |content|
				print content
				print "\n"
			end
			next if i == @staffNum
			print "--\n"
		end
	end

	# スタッフIDから表示されるメッセージを取得
	# @param [Numeric] スタッフID
	# @return [Array] メッセージログの配列
	def getMessageLogsFromId(staffId)
		result = []
		groupIds = getGroupIds(staffId)
		@messageDatas.each do |message|
			if hasStaffAuthority(staffId, message, groupIds)
				result.push message[:content]
			end
		end
		return result
	end

	# スタッフはメッセージを表示する権限があるか？
	# @param [Numeric] スタッフID
	# @param [Hash] メッセージ
	# @param [Numeric] グループID
	# @return [bool]
	def hasStaffAuthority(staffId, message, groupIds)
		result = false
		case message[:type]
		when "0" then # personal
			if staffId.to_s == message[:target] ||
				staffId.to_s == message[:owner]
					result = true
			end
		when "1" then # group
			if groupIds.include?(message[:target]) ||
				 staffId.to_s == message[:owner]
				result = true
			end
		end
		return result
	end

	# スタッフが持つグループIDを取得
	# @param [Numeric] スタッフのID
	# @return [Array] スタッフに紐づくグループIDの配列
	def getGroupIds(staffId)
		result = []
		@groupDatas.each do |group|
			if (group[:member].include?(staffId.to_s))
				result.push group[:id]
			end
		end
		return result
	end
end

chatLog = ChatMessageManager.new
chatLog.create
chatLog.read
