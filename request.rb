 require 'csv'

class MySqliteRequest
  def initialize
    @type_of_request_params = :none
    @type_of_request = @type_of_request_params
    @select_columns_req = []
    @select_columns = @select_columns_req
    @where_params_oren = []
    @where_params = @where_params_oren
    @insert_attributes_pra = {}
    @insert_attributes = @insert_attributes_pra
    @table_name = nil
    @order_por = :asc
    @order = @order_por
  end

  def from(table_name)
    @table_name = table_name
    self
  end

  def select(columns)
    @select_columns += columns.is_a?(Array) ? columns.map(&:to_s) : [columns.to_s]
    _set_type_of_request_req(:select)
    self
  end

  def where(column_name, criteria)
    @where_params << [column_name, criteria]
    self
  end

  def join(column_on_db_a, filename_db_b, column_on_db_b)
    self
  end

  def order(order, column_name)
    self
  end

  def insert(table_name)
    _set_type_of_request_req(:insert)
    @table_name = table_name
    self
  end

  def values(data)
    @insert_attributes = data
    self
  end

  def update(table_name)
    _set_type_of_request_req(:update)
    @table_name = table_name
    self
  end

  def set(data)
    @insert_attributes = data
    self
  end

  def delete
    _set_type_of_request_req(:delete)
    self
  end

  def update_delete_file_request(result)
    CSV.open(@table_name, 'w', headers: true) do |n|
      n << result[0].to_hash.keys
      result.each { |nba| n << CSV::Row.new(nba.to_hash.keys, nba.to_hash.values) }
    end
  end

  def print_select_type(result = nil)
    if !result
      return
    end

    if result.empty?
      no_information_found
    else
      print_result_table(result)
    end
  end

  def print_insert_type
    puts "Insert Attributes #{@select_columns}"
  end

  def print
    puts "Type of request #{@type_of_request}"
    puts "Table name #{@table_name}"
    print_select_type if @type_of_request == :select
    print_insert_type if @type_of_request == :insert
  end

  def run
    print
    case @type_of_request
    when :select
      param = _run_select_req
      print_select_type(param)
    when :insert
      _run_insert_request
    when :update
      update_params = _run_update_req_sqlite
      update_delete_file_request(update_params)
    when :delete
      delete_params = _run_delete_req
      update_delete_file_request(delete_params)
    end
  end

  private

  def _set_type_of_request_req(new_type)
    if @type_of_request == :none || @type_of_request == new_type
      @type_of_request_params = new_type
      @type_of_request = @type_of_request_params
    else
      raise 'Invalid request'
    end
  end

  def no_information_found
    puts 'No information found'
  end

  def print_result_table(result)
    puts result.first.keys.join(' | ')
    len = result.first.keys.join(' | ').length
    puts '-_' * len
    result.each { |line| puts line.values.join(' | ') }
    puts '-_' * len
  end

  def _run_select_req
    req_data = CSV.parse(File.read(@table_name), headers: true)
    data = req_data
    result = []

    if @select_columns.any? && @where_params.any?
      data.each do |row|
        @where_params.each do |where_attribute|
          if row[where_attribute[0]] == where_attribute[1]
            result << row.to_hash.slice(*@select_columns)
          end
        end
      end
    elsif @select_columns.any? && @where_params.empty?
      data.each do |row|
        @select_columns.each do |sel_col|
          result << (row[sel_col] ? row.to_hash.slice(*@select_columns) : row.to_hash)
        end
      end
    end

    result
  end

  def _run_insert_request
    File.open(@table_name, 'a') do |n|
      n.puts @insert_attributes.values.join(',')
    end
  end

  def _run_update_req_sqlite
    data = CSV.parse(File.read(@table_name), headers: true)
    result = []

    data.each do |row|
      @where_params.each do |header, body|
        if body == row[header]
          @insert_attributes.each do |header, body|
            row[header] = body
          end
        end
      end

      result << row
    end

    result
  end
  def _run_delete_req
    data = CSV.parse(File.read(@table_name), headers: true)
    result = []

    data.each do |row|
      @where_params.each do |header, body|
        result << row unless body == row[header]
      end
    end

    result
  end
end