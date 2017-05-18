require 'date'
require 'pp'

# カンファレンスにおいて、各人の持ち時間からタイムテーブルを作成
class ConferenceTimeTableManager
	def create
		load
		@currentDate = Time.gm(2016, 2, 23, 10, 00, 00) # AM10:00スタート
		@gotLunch = false
	end

	def read
		show
	end

	def load
		@peopleNum = gets.chomp.to_i
		@table = []
		for num in 0..(@peopleNum - 1)
			lineOver2Arr = gets.chomp.split(' ')
			@table[num] = { presenter:lineOver2Arr[0],
				mins: lineOver2Arr[1].to_i
			}
		end
	end

	def show
		for num in 0..(@peopleNum - 1)
			print @currentDate.strftime("%H:%M") + " - "
			mins =  (60 *  @table[num][:mins])
			@currentDate = @currentDate + mins
			print @currentDate.strftime("%H:%M") + " "
			print  @table[num][:presenter] + "\n"
			return if num == (@peopleNum - 1)
			restTime = takeRest @table[num + 1]
			@currentDate = @currentDate + restTime
		end
	end

	# 休憩、通常と昼休憩の2パターン
	# @param [Hash]
	# @return [Fixnum]
	def takeRest(row)
		result = isItLunchTime(row) ? (60 * 60): (10 * 60);
		return result
	end

	# （終了+休憩+発表の待ち時間）が12:01以降は昼休憩を取る
	# @param [Hash]
	# @return [Boolean]
	def isItLunchTime(row)
		return false if @gotLunch
		result = false
		nextTime = @currentDate + (10 * 60) + (row[:mins] * 60)
		restTime = Time.gm(2016, 2, 23, 12, 01, 00)
		if (restTime - nextTime) <= 0
			result = true
			@gotLunch = true
		end
		return result
	end
end

ctt = ConferenceTimeTableManager.new
ctt.create
ctt.read
