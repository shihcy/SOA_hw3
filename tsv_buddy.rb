# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  TAB = "\t".freeze
  NEWLINE = "\n".freeze

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    @data = tsv.split(NEWLINE)
		data1 = []
		@data.each {|element| data1 << element.to_s.split(TAB)}

		hash_data_arr = []
		i = 1
		(data1.length-1).times {
			hash_data = Hash.new
			j = 0
			data1[0].each { |symbol|
				hash_data[symbol] = data1[i][j]
				j+=1
			}
			hash_data_arr << hash_data
			i+=1
		}

		@data = hash_data_arr
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
  	@data
  end
end
