require 'readline'
require_relative 'my_sqlite_request'

def request_cli_params
  Readline.readline('my_sqlite_cli>> ', true)
end

def process_sql_command(sql)
  tokens = sql.split(' ')
  command = tokens.shift.downcase

  case command
  when 'select'
    execute_select_command(tokens)
  when 'insert'
    execute_insert_command(tokens)
  when 'update'
    execute_update_command(tokens)
  when 'delete'
    execute_delete_command(tokens)
  else
    puts 'Invalid command!'
  end
end

def execute_select_command(tokens)
  request = build_request(tokens)
  result = request.run
  print_result(result)
end

def execute_insert_command(tokens)
  request = build_request(tokens)
  request.run
end

def execute_update_command(tokens)
  request = build_request(tokens)
  request.run
end

def execute_delete_command(tokens)
  request = build_request(tokens)
  request.run
end

def build_request(tokens)
  request = MySqliteRequest.new
  until tokens.empty?
    option = tokens.shift
    case option
    when 'from', 'insert', 'update', 'delete'
      request = request.send(option, tokens.shift)
    when 'select', 'join', 'where', 'order'
      args = option == 'select' ? tokens : [tokens.shift, tokens.shift]
      request = request.send(option, *args)
    when 'values', 'set'
      data = {}
      loop do
        key = tokens.shift
        break if key == 'where' || key.nil?
        value = tokens.shift
        data[key] = value
      end
      request = request.send(option, data)
    end
  end
  request
end

def print_result(result)
  result.each { |row| puts row }
end

def run
  puts "Welcome to the MySQLite CLI!"
  puts "Available commands: SELECT, INSERT, UPDATE, DELETE"
  while (command = request_cli_params)
    process_sql_command(command)
  end
end

run
