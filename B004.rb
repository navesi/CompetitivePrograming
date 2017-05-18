require 'pp'

# ログから特定のIPのアクセスを抽出
class ExtractLogs
	def create
		load
		@ipRangeArr = convertIpStringToRangeArr(@ipAddress)
		putLogContent
	end

	def read
		show
	end

	def load
		# 1行目に検索条件として、IPアドレスが入力されます。
		# 範囲指定も可能で第3、第4オクテットは* (0から255全て)、
		# [S-E] (SからEまで)で指定することが可能です。
		@ipAddress = gets.chomp

		# 2行目には入力されるログの行数Nが入力されます。
		logNum = gets.chomp.to_i

		# 3行目以降には2行目で入力された行数分のApacheのログが入力されます。
		# ログ１行の長さMは500文字以内とします。
		@logs = []
		for i in 0..(logNum - 1)
			 lineOver3Arr = gets.chomp#.split(' ')
			 @logs[i] = { id: i,
				 log:lineOver3Arr
			 }
		end
	end

	def show
		# 入力されたIPアドレスの範囲のIPアドレスを入力されたログから抽出し、
		# IPアドレス、日付(+9000等のタイムゾーンの表記なし)、
		# ファイル名をスペース区切りで日付の古い順に出力してください。
		@logs.each do |log|
			# result =
			if isTargetIp?(log[:ip], @ipRangeArr)
				print getStringShowing(log) + "\n"
			end
		end
	end

	# Logの中身を読みHash要素に分ける
	def putLogContent
		pattern = /([^\s]+)\s[^\s]+\s[^\s]+\s\[([^\]]+)\]\s\"([^\"]+)\".*/
		@logs.each do |log|
			string = log[:log]
			result = string.match(pattern)
			log[:ip] = result[1]
			log[:date] = result[2]
			log[:request] = result[3]
		end
	end

	# 対象のIPか？
	# @param [String] 真偽を知りたいIP
	# @param [Numeric] IPの範囲
	# @return [Boolean]
	def isTargetIp?(targetIp, ipRange)
		result = true
		targetIpArr = targetIp.split('.')
		for i in 0..3
			if !ipRange[i].include?(targetIpArr[i].to_i)
				return false
			end
		end
		return result
	end

	# 調査対象IPを表す文字列を読み込みRangeに置き換える
	# @param [String]
	# @return [Array] Rangeの配列からなるIPアドレス
	def convertIpStringToRangeArr(targetIps)
		result = []
		octetArr = targetIps.split('.')
		pattern = /\[(\d+)\-(\d+)\]/
		octetArr.each do |octet|
			if octet[0] == "["
				res = octet.match pattern
				result.push(res[1].to_i..res[2].to_i)
			elsif octet[0] == "*"
				result.push(0..255)
			else
				result.push(octet.to_i..octet.to_i)
			end
		end
		return result
	end

	# 表示の型
	# @param [Hash]
	# @return [String]
	def getStringShowing(log)
		pattern = /([^\s]+)\s/
		date = log[:date].match(pattern)
		pattern2 = /GET\s([^\s]+)\s.*/
		request = log[:request].match(pattern2)
		result = log[:ip] + " " + date[1] + " " + request[1]
		return result
	end
end

el = ExtractLogs.new
el.create
el.read
