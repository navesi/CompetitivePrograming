require 'pp'

# 受け取ったアドレスからページを表示する。2つのコマンドがある。
class BrowsingManager

	def create
		load
	end

	def read
		show
	end

	# データを標準入力から読み込み、それぞれ対応した各パラメータに置いていく
	def load
		commandNum = gets.chomp.to_i
		@commandLogs = []
		@histories = []

		for num in 0..(commandNum - 1)
			@commandLogs[num] = { command: gets.chomp }
		end
		@currentPage = ""
	end

	# 指定のフォーマットに合わせた表示
	def show
		@commandLogs.each do |command|
			@currentPage  = getPageWithCommand(command, @currentPage)
			print @currentPage  + "\n"
		end
	end

	# 次に進むコマンド時の処理
	# @param [Hash] コマンド、次のページ名に使う。
	# @param [String] 前のページ名
	# @return [String] 次のページ名
	def gotoNext(command, prePage)
		nextPage = command[:command][6, command[:command].length]
		@histories.push(prePage)
		return nextPage
	end

	# 前の戻るコマンド時の処理
	# @return [String] 戻り先のページ名
	def backToLast
		# pp @histories
		nextPage = @histories.pop
		return nextPage
	end

	# コマンドを読み取りそれに沿った実行をし、結果のページを返す
	# @param [Hash] {}コマンド
	# @param [String]
	# @param [String] 結果ページ名
	def getPageWithCommand(command, prePage)
		resultPage = ""
		goto = "go to "
		useBB = "use the back button"
		if command[:command].include?(goto)
		  resultPage = gotoNext(command, prePage)
		elsif	command[:command].include?(useBB)
		  resultPage = backToLast
		end

		return resultPage
	end
end

b = BrowsingManager.new
b.create
b.read
