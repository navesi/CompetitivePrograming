require 'date'
require 'pp'
class ConferenceTable
	def read
		@peopleNum = gets.chomp.to_i
		@table = []
		for num in 0..(@peopleNum - 1)
			lineOver2Arr = gets.chomp.split(' ')
			@table[num] = { presenter:lineOver2Arr[0], mins: lineOver2Arr[1].to_i }
		end
		@currentDate = Time.gm(2016, 2, 23, 10, 00, 00)
		@gotLunch = false
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

	def takeRest row
		result = isItLunchTime(row) ? (60 * 60): (10 * 60);
		return result
	end

	def isItLunchTime row
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

ct = ConferenceTable.new
ct.read
ct.show