# サッカーのルール。オフサイド判定を行う
class SoccerRuleManager

	def create
		loadAndParse
		updateOffsideTargetWithAllRule
	end

	def read
		if @offsideTarget.length == 0
			print "None"
		else
			@offsideTarget.each do |target|
				print target[:number].to_s + "\n"
			end
		end #eo if
	end

	# データを標準入力から読み込み、それぞれ対応した各パラメータに置いていく
	def loadAndParse
		line1arr = gets.chomp.split(' ')
		@passer = {}
		@passer[:team ] = line1arr[0]
		@passer[:number ] = line1arr[1].to_i

		line2arr = gets.chomp.split(' ')
		@teamA = []
		i = 1
		line2arr.each do |pos|
		  @teamA.push ({:number => i, :team => "A", :position => pos.to_i })
		  i += 1
		end

		@teamB = []
		j=1
		line3arr = gets.chomp.split(' ')
		line3arr.each do |posB|
		  @teamB.push ({:number => j, :team => "B", :position => posB.to_i})
		  j += 1
		end
	end

	# 現時点でオフサイド判定になりえるターゲットをセットする
	# パサーのポジションもセットｋ
	def updateOffsideTargetWithAllRule
		offenceTeam = (@passer[:team] == "A") ? @teamA: @teamB
		defenceTeam = (@passer[:team] == "A") ? @teamB: @teamA
		# パサーのポジションをセット
		offenceTeam.each do |mem|
			if mem[:number] == @passer[:number]
				@passer[:position] = mem[:position]
				break
			end
		end
		defendSideSecondPos = getPositionSecondPlayer(defenceTeam)
		@offsideTarget = []
		offenceTeam.each do |member|
			inArea = isRecieverInEnemyArea(member) # 2nd Rule
			nearThanPasser = isRecieverNearToGoalThan(member, @passer[:position]) # 3rd rule
			nearThanDefender = isRecieverNearToGoalThan(member, defendSideSecondPos) # 4th rule
			if inArea && nearThanPasser && nearThanDefender
				@offsideTarget.push(member)
			end
		end
	end

	# 受け取る側が相手側にいる場合
	# ルール2
	# @param [Hash] 受け取るプレイヤー
	# @return [Boolean] ルールを満たすか
	def isRecieverInEnemyArea(targetMember)
		result = false
		case targetMember[:team]
		when "A" then
			if ( targetMember[:position].between?(55,110))
				result = true
			end
		when "B" then
			if ( targetMember[:position].between?(0,55))
				result = true
			end
		else
		end # eo case
		return result
	end

	# 受け取る側が近いか？
	# ルール3とルール4での比較に使う
	# @param [Hash] ボールを受け取るプレイヤー
	# @param [Numeric] 比較対象のポジションX
	# @return [Boolean] ルールを満たすか
	def isRecieverNearToGoalThan(reciever, target)
		result = false
		case @passer[:team]
		when "A" then
			if reciever[:position] > target
				result = true
			end
		when "B" then
			if reciever[:position] < target
				result = true
			end
		else
		end
		return result
	end

	# ポジションXを取得
	# @param [Array] PlayerHash列
	# @return [Numeric] ディフェンス側のゴールに2番めに近いプレイヤー位置
	def getPositionSecondPlayer(defenceTeam)
		posArr = []
		defenceTeam.each do |enemy|
			posArr.push enemy[:position]
		end
		posArr.sort!
		case @passer[:team]
		when "A" then
			posArr.reverse!
		else
		end
		result = posArr[1] # No.2
		return result
	end
end

soccer = SoccerRuleManager.new
soccer.create
soccer.read
