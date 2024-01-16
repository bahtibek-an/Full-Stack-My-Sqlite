require "readline"

class MySqliteQuerysCli
    def parser(buf)
        p buf
    end

    def run!
        while buf = Readline.readline(">",true)
        instance_of_request = parser(buf)
        end
    end
end

mysqlite = MySqliteQuerysCli.new
mysqlite.run!