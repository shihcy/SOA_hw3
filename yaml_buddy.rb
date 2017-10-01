# Module that can be included (mixin) to take and output Yaml data
require 'yaml'

module YamlBuddy
  TAB = "\t".freeze
  NEWLINE = "\n".freeze

  # take_yaml: converts a String with YAML data into @data
  # parameter: yaml - a String in YAML format
  def take_yaml(yaml)
  	@data = (yaml.split("\n   ")).join
  	@data = @data.split("\n- ")
  	@data = @data[1..-1]

		#split data
		a = []
		@data.each {|term|a << term.split("\n  ")}
		a[-1][-1] = a[-1][-1].delete(NEWLINE)

		b = []
		a.each {|term|
			c = []
			term.each {|element| c << (element.delete("'")).split(": ")}
			b << c
		}
		split_data = b

		#hash key
		key_arr = []
		(split_data[0].length).times {|i| key_arr << split_data[0][i][0]}

		#hash value
		value_arr = []
		(split_data).each {|term|
			temp = []
			term.each {|element| temp << element[1]}
			value_arr << temp
		}

		#to tsv
		key_str = key_arr.join(TAB)

		value_str = ""
		temp_arr = []
		value_arr.each {|term| temp_arr << term.join(TAB)}
		value_str = temp_arr.join(NEWLINE)
	  
	  @data = ""
	  @data = key_str + NEWLINE + value_str + NEWLINE
  end

  # to_yaml: converts @data into yaml string
  # returns: String in YAML format
  def to_yaml
    @data.to_yaml
  end
end
