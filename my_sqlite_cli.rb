require 'readline'
require_relative 'request'

def request_cli_params
  Readline.readline('my_sqlite_cli>> ', true)
end

def parse_params(arr)
  arr.map { |item| item.split('=') }.to_h
end

def execute_sqlite_request(action, args, request)
  case action
  when 'from'
    request.from(*args)
  when 'select'
    request.select(*args)
  when 'where'
    col, val = args[0].split('=')
    request.where(col, val)
  when 'insert'
    request.insert(*args)
  when 'values'
    request.values(parse_params(args))
  when 'update'
    request.update(*args)
  when 'set'
    request.set(parse_params(args))
  when 'delete'
    request.delete
  else
    handle_undefined_method
  end
end

def handle_undefined_method
  puts 'Undefined method!'
end

def handle_request_error
  puts "Finish your request with ';'"
end

def run
  puts "MySQLite version 6.0.0 2022.12.08\n';' do not forget to put a mark\n"
  while command = request_cli_params
    break if command == 'exit'

    process_sql_command(command)
  end
end

def process_sql_command(sql)
  valid_actions = %w[SELECT FROM WHERE INSERT VALUES UPDATE SET DELETE]
  command = nil
  args = []
  request = MySqliteRequest.new # Assuming you've defined this class

  splited_command = sql.split(' ')

  splited_command.each do |arg|
    if valid_actions.include?(arg.upcase)
      execute_sqlite_request(command, args, request) if command
      command = arg.downcase
      args = []
    else
      args << arg
    end
  end

  if args[-1]&.end_with?(';')
    args[-1] = args[-1].chomp(';')
    execute_sqlite_request(command, args, request)
    request.run
  else
    handle_request_error
  end
end

run