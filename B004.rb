require 'pp'

class ExtractLogs
	def read
		#		1行目に検索条件として、IPアドレスが入力されます。
		#範囲指定も可能で第3、第4オクテットは* (0から255全て)、
		#[S-E] (SからEまで)で指定することが可能です。
		@ipAddress = gets.chomp

		# 2行目には入力されるログの行数Nが入力されます。
		logNum = gets.chomp.to_i

		# 3行目以降には2行目で入力された行数分のApacheのログが入力されます。
		#ログ１行の長さMは500文字以内とします。
		@logs = []
		for i in 0..(logNum - 1)
			 lineOver3Arr = gets.chomp#.split(' ')
			 @logs[i] = { id: i,
									log:lineOver3Arr
									}		
		end
		# pp @logs
		@ipRangeArr = parseIpToRangeArr @ipAddress
	end

	def show
		#入力されたIPアドレスの範囲のIPアドレスを入力されたログから抽出し、
		#IPアドレス、日付(+9000等のタイムゾーンの表記なし)、
		#ファイル名をスペース区切りで日付の古い順に出力してください。
		@logs.each do |log|
			result = isTarget log[:ip], @ipRangeArr
			if result
				print getStringFormat(log) + "\n"
	
				
			end
		end
	end

	def updateLog
		# match(Stringクラス メソッド)
		# pattern = /([^\s]+)\s[^\s]+\s[^\s]+\s\[([^\]]+)\]\s\"([^\"]+\").*/
		pattern = /([^\s]+)\s[^\s]+\s[^\s]+\s\[([^\]]+)\]\s\"([^\"]+)\".*/
		# pattern1 = /^([^\s]+)\s.*/
		# pattern2 = /\[[(^\]+)]\]/
		# pattern2 = /.*\[[^(\]+)]\].*/
		# pattern3 = /.*\"[(^\")]\".*/

		@logs.each do |log|
			string = log[:log]
			result = string.match(pattern)
			log[:ip] = result[1]
			log[:date] = result[2]
			log[:request] = result[3]
			# ip = string.match(pattern1)
			# log[:ip] = ip[1]
			# date = string.match(pattern2)
			# log[:date] = date
			# request = string.match(pattern3)
			# log[:request] = request

		end

	end

	def isTarget targetIp, ipRange
		result = true

		targetIpArr = targetIp.split('.')

		for i in 0..3

			unless ipRange[i].include?(targetIpArr[i].to_i)
				return false
			end
		end

		return result
	end

	def parseIpToRangeArr ipAddressrange
		result = []
		ipArr = ipAddressrange.split('.')
		pattern = /\[(\d+)\-(\d+)\]/
		ipArr.each do |one|
			if one[0] == "["
				# range#
				res = one.match pattern
				result.push res[1].to_i..res[2].to_i
			elsif one[0] == "*"
				result.push 0..255
			else
				result.push one.to_i..one.to_i
			end
		end

		return result
	end

	def getStringFormat log

		pattern = /([^\s]+)\s/
		date = log[:date].match pattern
		pattern2 = /GET\s([^\s]+)\s.*/

		request = log[:request].match pattern2	

		result = log[:ip] + " " + date[1] + " " + request[1]
		return result
	end
end

el = ExtractLogs.new
el.read
el.updateLog
el.show