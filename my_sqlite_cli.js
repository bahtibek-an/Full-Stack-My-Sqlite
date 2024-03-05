const readlineSync = require('readline-sync');

class MySqliteCLI {
  constructor(database) {
    this.database = database;
    this.request = new MySqliteRequest();
  }

  run() {
    console.log('MySQLite version 0.1 20XX-XX-XX');

    while (true) {
      const input = readlineSync.question('my_sqlite_cli> ');
      if (input.toLowerCase() === 'quit') {
        break;
      }

      this.executeCommand(input);
    }
  }

  executeCommand(input) {
    // Parse the input and execute the respective command
    // ...
  }
}

const database = 'class.db';
const cli = new MySqliteCLI(database);
cli.run();