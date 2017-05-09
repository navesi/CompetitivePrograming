require 'pp'
class Browsing
	def read
		commandNum = gets.chomp.to_i
		@commandLogs = []
		@histories = []

		for num in 0..(commandNum - 1)
			@commandLogs[num] = { command: gets.chomp }
		end
		@currentPage = ""
	end

	def show
		@commandLogs.each do |command|
			@currentPage  = parseCommand command, @currentPage 
			print @currentPage  + "\n"
		end
	end

	def gotoNext command, prePage
		# nextPage = ""
		nextPage = command[:command][6, command[:command].length]
		@histories.push(prePage) 
		return nextPage
	end

	def backToLast
		# pp @histories
		nextPage = @histories.pop
		return nextPage
	end

	def parseCommand command, prePage
		resultPage = ""
		goto = "go to "
		useBB = "use the back button"
		if command[:command].include?(goto) then
		  resultPage = gotoNext command, prePage
		elsif	command[:command].include?(useBB) then
		  resultPage = backToLast
		end

		# command
		return resultPage
	end
end

b = Browsing.new
b.read
b.show