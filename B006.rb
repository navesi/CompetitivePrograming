require 'pp'
# require 'Math'
class DartsGame
	def read

		# 1行目には初期値点の高さo_y,矢の初速s,角度θがスペース区切りの数値で入力されます。

		line1 = gets.chomp.split(' ')
		@start = { height: line1[0].to_i,
								speed: line1[1].to_i,# m/sec
								angle: line1[2].to_i
		}
		# 2行目には的までの距離xと高さyと的の大きさがスペース区切りの数値で入力されます。
		line2 = gets.chomp.split(' ')
		@target = { x: line2[0].to_i,
								y: line2[1].to_i,
								across: line2[2].to_i
		}

	end

	def show

		result = getTrack
		# print result.round(1)
		if isHit result
			print "Hit " + (@target[:y] - result).round(1).abs.to_s
		else
			print "Miss"
		end

	end

	def getTrack
		rad = @start[:angle] * Math::PI / 180
		left = @start[:height]
		center = @target[:x] * Math.tan(rad)
		rightUnder = 2 * @start[:speed] ** 2 * Math.cos(rad) ** 2
		rightTop = (9.8) * (@target[:x] ** 2)

		result = left + center - (rightTop / rightUnder)

		return result
	end

	def isHit double
		result = false
		under = @target[:y] - (@target[:across] / 2)
		top = @target[:y] + (@target[:across] / 2)
		if (under..top).include? double
			result = true
		end
		return result
	end
end
dg = DartsGame.new
dg.read
dg.show