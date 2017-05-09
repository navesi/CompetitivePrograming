#!/Users/kouji/.rbenv/shims/ruby


class IpLine
	# @ip_line
	def initialize ip_line
		@ip_line_arr = ip_line
	end
	#
	def is_four
		unless @ip_line_arr.length == 4 then
			return false
		end
		return true
	end

	#
	def is_right_num 
			# 0 =< n =< 255
		@ip_line_arr.each do |num|
			if num.to_f < 0 || num.to_f > 255
				# puts "数字でかいor小さい"
				# next
				return false
			end
		end
		return true
	end
end

#puts "test"

input_lines = gets.to_i
input_lines.times {
	puts " --- "
#   s = gets.chomp.split(",")
#   print "hello = ",s[0]," , world = ",s[1],"\n"


	# Split with piriod
	ip = gets.chomp.split(".")
	ip_line = IpLine.new(ip)
	if !ip_line.is_four() 
		puts ip
		puts "False" 
		next
	end


	# 4つ？
	if !ip_line.is_right_num()
		puts ip
		puts "False"
		next
	end


	# 出力
	puts "True"
}