require 'pp'

# 放物線を描く矢が的に命中するか判定
class DartsGameManager
	def create
		load
	end

	def load
		# 1行目には初期値点の高さo_y,矢の初速s,角度θがスペース区切りの数値で入力されます。
		line1 = gets.chomp.split(' ')
		@arrowData = { height: line1[0].to_i,
								speed: line1[1].to_i,# m/sec
								angle: line1[2].to_i
		}
		# 2行目には的までの距離xと高さyと的の大きさがスペース区切りの数値で入力されます。
		line2 = gets.chomp.split(' ')
		@targetData = { x: line2[0].to_i,
								y: line2[1].to_i,
								diameter: line2[2].to_i
		}
	end

	def read
		arrowHeight = getArrowHeightEndLine
		show(arrowHeight)
	end

	# @param [Float] Xの時点の矢の高さ
	def show(arrowHeight)

		if isArrowHitTarget?(arrowHeight)
			print "Hit " + (@targetData[:y] - arrowHeight).round(1).abs.to_s
		else
			print "Miss"
		end
	end

	# 的の距離まで到達した時点での矢の高さを数式から求める
	# @return [Float] Xの時点の矢の高さ
	def getArrowHeightEndLine
		rad = @arrowData[:angle] * Math::PI / 180
		first = @arrowData[:height]
		second = @targetData[:x] * Math.tan(rad)
		third = (9.8) * (@targetData[:x] ** 2)
		fourth = 2 * @arrowData[:speed] ** 2 * Math.cos(rad) ** 2

		result = first + second - (third / fourth)
		return result
	end

	# 矢が的に当たったか？ 矢の高さを受取り、的のサイズと比較する。
	# @param [Float] 距離Xでの矢の高さ
	# @return [Boolean] 的を射たかの成否
	def isArrowHitTarget?(arrowHeight)
		result = false
		under = @targetData[:y] - (@targetData[:diameter] / 2)
		top = @targetData[:y] + (@targetData[:diameter] / 2)
		if (under..top).include? arrowHeight
			result = true
		end
		return result
	end
end
dg = DartsGameManager.new
dg.create
dg.read
