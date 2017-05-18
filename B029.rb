require 'pp'

# k-近傍方で地価を算出する
class LandPriceManager

	def create
		load
		putMagnitude
	end

	def read
		result = getPrice
		print result
	end

	# データを標準入力から読み込み、それぞれ対応した各パラメータに置いていく
	def load
		@position = {}
		line1Arr = gets.chomp.split(' ')
		@position = { x:line1Arr[0].to_i, y:line1Arr[1].to_i }
		@k = gets.chomp.to_i # サンプル母数の数
		sampleLandNum = gets.chomp.to_i
		@sampleLandDatas = []
		for num in 0..(sampleLandNum - 1)
			lineOver3Arr = gets.chomp.split(' ')
			@sampleLandDatas[num] = { x:lineOver3Arr[0].to_i,
														y:lineOver3Arr[1].to_i,
														price:lineOver3Arr[2].to_i }
		end
	end

	# データにNumeric [:magnitude]を追加
	def putMagnitude
		@sampleLandDatas.each do |land|
			mag = getMagnitude(@position[:x],
				@position[:y],
				land[:x],
				land[:y])
			land[:magnitude] = mag
		end
	end

	# 2点の距離を求める
	# @param [Numeric] Aの位置X
	# @param [Numeric] Aの位置Y
	# @param [Numeric] Bの位置X
	# @param [Numeric] Bの位置Y
	# @return [Numeric] 距離
	def getMagnitude(x1, y1, x2, y2)
		length = (x1 - x2 ) ** 2 + (y1 - y2) ** 2
		result = length ** (1/2.0)
		return result
	end

	# sampleLandDatasからkｰ近傍法で土地価格を求める
	# @return [Numeric] 値段
	def getPrice
		result = 0
		targetPlaces = []

		@sampleLandDatas.sort_by! { |hsh| hsh[:magnitude] }
		targetPlaces = @sampleLandDatas.slice(0..(@k - 1))

		targetPlaces.each do |place|
			result += place[:price]
		end
		result = (result / @k).round
		return result
	end
end

lp = LandPriceManager.new
lp.create
lp.read
