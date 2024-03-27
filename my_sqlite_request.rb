require 'csv'

class MySqliteRequest
  def initialize(table_name = nil)
    @table_name = table_name
    @select_columns = []
    @where_conditions = []
    @join_table_name = nil
    @join_condition = nil
    @order_column = nil
    @order_direction = nil
    @insert_data = {}
    @update_data = {}
    @delete_request = false
  end

  def from(table_name)
    @table_name = table_name
    self
  end

  def select(*columns)
    @select_columns += columns
    self
  end

  def where(column_name, value)
    @where_conditions << { column_name: column_name, value: value }
    self
  end

  def join(column_on_db_a, filename_db_b, column_on_db_b)
    @join_table_name = filename_db_b
    @join_condition = { column_on_db_a: column_on_db_a, column_on_db_b: column_on_db_b }
    self
  end

  def order(order, column_name)
    @order_direction = order
    @order_column = column_name
    self
  end

  def insert(table_name)
    @table_name = table_name
    self
  end

  def values(data)
    @insert_data = data
    self
  end

  def update(table_name)
    @table_name = table_name
    self
  end

  def set(data)
    @update_data = data
    self
  end

  def delete
    @delete_request = true
    self
  end

  def run
    if @delete_request
      execute_delete
    elsif @update_data.any?
      execute_update
    elsif @insert_data.any?
      execute_insert
    else
      execute_select
    end
  end

  private

  def execute_select
    data = CSV.read(@table_name, headers: true)
    filtered_data = data.select do |row|
      @where_conditions.all? { |condition| row[condition[:column_name]] == condition[:value] }
    end
    filtered_data.map { |row| row.to_h.slice(*@select_columns) }
  end

  def execute_insert
    CSV.open(@table_name, 'a') do |csv|
      csv << @insert_data.values
    end
  end

  def execute_update
    data = CSV.read(@table_name, headers: true)
    data.each do |row|
      if @where_conditions.all? { |condition| row[condition[:column_name]] == condition[:value] }
        @update_data.each { |key, value| row[key] = value }
      end
    end
    CSV.open(@table_name, 'w') do |csv|
      csv << data.headers
      data.each { |row| csv << row }
    end
  end

  def execute_delete
    data = CSV.read(@table_name, headers: true)
    data.delete_if do |row|
      @where_conditions.all? { |condition| row[condition[:column_name]] == condition[:value] }
    end
    CSV.open(@table_name, 'w') do |csv|
      csv << data.headers
      data.each { |row| csv << row }
    end
  end
end
