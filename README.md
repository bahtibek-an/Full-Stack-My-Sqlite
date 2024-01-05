# Description

Create a class called MySqliteRequest in my_sqlite_request.rb. It will have a similar behavior than a request on the real sqlite.

All methods, except run, will return an instance of my_sqlite_request. You will build the request by progressive call and execute the request by calling run.

Each row must have an ID.

We will do only 1 join and 1 where per request.

# Task

request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request = request.where('birth_state', 'Indiana')
request.run
=> [{"name" => "Andre Brown"]

Input: MySqliteRequest.new('nba_player_data').select('name').where('birth_state', 'Indiana').run
Output: [{"name" => "Andre Brown"]

# Installation

npm install
wget https://storage.googleapis.com/qwasar-public/nba_player_data.csv
wget https://storage.googleapis.com/qwasar-public/nba_players.csv

# Usage