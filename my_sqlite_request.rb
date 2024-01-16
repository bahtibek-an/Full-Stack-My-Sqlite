require 'csv'


class MySqliteRequest 
	def initialize
		@type_of_request = :none
		@select_columns  = []
		@where_params    = []
		@insert_attributes = {}
		@table_name      = nil
		@order           = :asc
	end

	def from(table_name)
		@table_name = table_name
		self
	end

	# def select(array)
	# 	if (columns.is_a?(Array))
	# 		@select_columns += columns.collect {|elem| elem.to_s}
	# 	else
	# 		@select_columns << columns.to_s	
	# 	end
	# 	self._setTypeOfRequest(:select)
	# 	self
	# end

	def select(array)
	    if array.is_a?(Array)
	      @select_columns += array.map { |elem| elem.to_s }
	    else
	      @select_columns << array.to_s
	    end
	    _setTypeOfRequest(:select)
	    self
  	end

	def where(column_name, criteria)
		@where_params << [column_name , criteria]
		self
	end

	def join(column_on_db_a, filename_db_b, column_on_db_b)
		self
	end

	def order(order, column_name)
		self
	end

	def insert(table_name)
		self._setTypeOfRequest(:insert)
		@table_name = table_name
		self
	end

	def values(data)
		if(@type_of_request == :insert)
			@insert_attributes = data
		else
			raise 'wrong type of request to call values()'
		end
		self
	end

	def update(table_name)
		self._setTypeOfRequest(:update)
		@table_name = table_name
		self
	end

	def set(data)
		self
	end

	def print 
		puts "Type of Request #{@type_of_request}"
		puts "Table Name #{@table_name}"
		if (@type_of_request == :select)
			print_select_type
		elsif(@type_of_request == :insert)
			print_insert_type			
		end
	end

	def print_select_type 
		puts "Select Attributes #{@select_columns}"
		puts "where Attributes #{@where_params}"
	end

	def print_insert_type 
		puts "Insert Attributes #{@insert_attributes}"
	end

	def run
		print
		if (@type_of_request == :select)
			_run_select	
		elsif(@type_of_request == :insert)
			_run_insert			
		end
	end

	def delete
		self._setTypeOfRequest(:delete)
		self
	end

	def _setTypeOfRequest(new_type)
		if (@type_of_request == :none or @type_of_request == new_type)
			@type_of_request = new_type
		else
			raise "Invalide: type of request already set to #{@type_of_request} (new type =>#{new_type}"		
		end
	end


	def _run_select
		result = []
		CSV.parse(File.read(@table_name), headers: true).each do |row|
			@where_params.each do |where_attribute|
				if row[where_attribute[0]] == where_attribute[1]
					result << row.to_hash.slice(*@select_columns)
				end
			end
		end
		result
	end

	def _run_insert
		File.open(@table_name, "a") do |f|
			f.puts @insert_attributes.values.join(',')
		end
	end

end

def _main()
=begin
	request = MySqliteRequest.new
	request = request.from('nba_player_data.csv')
	request = request.select('name')X
	request = request.where('year_start', '1991')
	p request.run
=end
	request = MySqliteRequest.new
	request = request.insert('nba_player_data_light.csv')
	request = request.values({"name" => "Don Adams",
	"year_start" =>"1971",
	"year_end" =>"1977",
	"position" =>"F",
	"height" =>"6-6",
	"weight" =>"210",
	"birth_date" =>"November 27, 1947",
	"college" =>"Northwestern University"
	})
	request.run
end

_main()
