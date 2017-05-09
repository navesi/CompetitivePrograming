require 'pp'

class LandPrice

	def read
		@target = {}
		line1Arr = gets.chomp.split(' ')
		@target = { x:line1Arr[0].to_i, y:line1Arr[1].to_i }
		@k = gets.chomp.to_i
		pointNum = gets.chomp.to_i
		@landPrices = []
		for num in 0..(pointNum - 1)
			lineOver3Arr = gets.chomp.split(' ')
			@landPrices[num] = { x:lineOver3Arr[0].to_i,
														y:lineOver3Arr[1].to_i,
														price:lineOver3Arr[2].to_i }
		end
	
	end

	def show
		result = prediction
		print result
	end

	def prediction
		result = 0
		targetPlaces = []

		@landPrices.sort_by! { |hsh| hsh[:magnitude] }
		pp @landPrices
		targetPlaces = @landPrices.slice(0..(@k - 1))

		targetPlaces.each do |place|
			result += place[:price]
		end
		result = (result / @k).round
		return result
	end

	def magnitude x1, y1, x2, y2
		length = (x1 - x2 ) ** 2 + (y1 - y2) ** 2
		result = length ** (1/2.0)
		return result
	end

	def updateMagnitude
				# pp @landPrices
		@landPrices.each do |land|
			mag = magnitude @target[:x], @target[:y], land[:x], land[:y]
			land[:magnitude] = mag
		end
		# pp @landPrices
	end
end

lp = LandPrice.new
lp.read
lp.updateMagnitude

lp.show