require_relative "my_sqlite_request"

def request_cli_params
    print 'my_sqlite_cli>> '
    files = gets.chomp
    file = files
    return file
end

def set_type_of_params(arr)
    result_1 = Hash.new
    result = result_1 
    i = 0
    while i < arr.length 
        header, body = arr[i].split("=")
        result[header] = body
        i += 1
    end
    return result
end

def type_request_cli_sqlite(action, args, request)
  case action
  when "from"
      request.from(*args)
  when "select"
      request.select(args)
  when "where"
      col, val = args[0].split("=")
      request.where(col, val)
  when "insert"
      request.insert(*args)
  when "values"
      request.values(set_type_of_params(args))
  when "update"
      request.update(*args)
  when "set"
      request.set(set_type_of_params(args))
  when "delete"
      request.delete
  else
      puts "Undefined method!"
  end
end



def sqlite_type_cli(sql)
  valid_actions_e = ["SELECT", "FROM", "WHERE", "INSERT", "VALUES", "UPDATE", "SET", "DELETE"]
  valid_actions = valid_actions_e
  command_req = nil
  command = command_req
  args = []
  request = MySqliteRequest.new
  splited_command_param = sql.split(" ")
  splited_command = splited_command_param
  
  splited_command.each do |arg|
      case
      when valid_actions.include?(arg.upcase())
          if command
              if command != "..."
                  args = args.join(" ").split(", ")
              end
              type_request_cli_sqlite(command, args, request)
              command = nil
              args = []
          end
          command = arg.downcase()
      else
          args << arg
      end
  end
  
  if args[-1].end_with?(";")
      args[-1] = args[-1].chomp(";")
      type_request_cli_sqlite(command, args, request)
      request.run
  else
      puts "Finish your request with -> ';' "
  end
end




def run
    puts "MySQLite version 6.0.0 2022.12.08\n';' do not forget to put a mark\n"
    while command = request_cli_params
        if command == "exit"
            break
        else
            sqlite_type_cli(command)
        end
    end
end

run()
