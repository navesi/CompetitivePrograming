class Soccer
	def read
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

	def show

		if(@passer[:team] =="A")
			myTeam = @teamA
			enemyTeam = @teamB
		else
			myTeam = @teamB
			enemyTeam = @teamA
		end

		myTeam.each do |mem| 
			if mem[:number] == @passer[:number]
				@passer[:position] = mem[:position]
				break
			end
		end

		enemySecondPos = getEnemySecondPos enemyTeam
		offsideTarget = []

		myTeam.each do |member|
			bool = secondRule member
			cool = thirdRule member 
			dool = fourthRule member, enemySecondPos

			if bool && cool && dool
				offsideTarget.push(member)
			end
		end

		if offsideTarget.length == 0
			print "None"
		else
			offsideTarget.each do |target|
				print target[:number].to_s + "\n"
			end
		end #eo if

	end

	# in enemy area
	def secondRule targetMember
		result = false
		case targetMember[:team]
		when "A" then
			# if (55..110).between? targetMember[:position]
			if ( targetMember[:position].between?(55,110))
				result = true
			end
		when "B" then
			# if (0..55).between? targetMember[:position]
			if ( targetMember[:position].between?(0,55))
				result = true
			end
		else
		end# eo case
		return result
	end

	# near goal than passer
	def thirdRule targetMember
		# pp @passer
		# pp targetMember
		result = false
		# passerPos = @passer[:position]

		case @passer[:team]
		when "A" then
			if targetMember[:position] > @passer[:position]
				result = true
			end
		when "B" then
			if targetMember[:position] < @passer[:position]
				result = true
			end
		else
		end# eo case
		# pp result
		return result
	end

	# near goal than enemy 2nd
	def fourthRule targetMember, enemySecondPos
		result = false
		case @passer[:team]
		when "A" then
			if targetMember[:position] > enemySecondPos

				result = true
			end
		when "B" then
			if targetMember[:position] < enemySecondPos
				result = true
			end
		else
		end# eo case
		return result

	end

	def getEnemySecondPos enemyTeam
		posArr = []
		enemyTeam.each do |enemy|
			posArr.push enemy[:position]
		end
		posArr.sort!

		case @passer[:team]
		when "A" then
			posArr.reverse!
		else
		end# eo case

		result = posArr[1] # no 2

		return result
	end
end

soccer = Soccer.new
soccer.read
soccer.show