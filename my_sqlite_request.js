class MySqliteRequest {
    constructor(table_name = null) {
      this.table_name = table_name;
      this.columns = [];
      this.conditions = [];
      this.join_table = null;
      this.join_column_a = null;
      this.join_column_b = null;
      this.order_column = null;
      this.order_direction = null;
      this.insert_data = {};
      this.update_data = {};
      this.delete_flag = false;
    }
  
    from(table_name) {
      this.table_name = table_name;
      return this;
    }
  
    select(column_names) {
      if (Array.isArray(column_names)) {
        this.columns.push(...column_names);
      } else {
        this.columns.push(column_names);
      }
      return this;
    }
  
    where(column_name, value) {
      this.conditions.push({ column: column_name, value: value });
      return this;
    }
  
    join(column_on_db_a, filename_db_b, column_on_db_b) {
      this.join_table = filename_db_b;
      this.join_column_a = column_on_db_a;
      this.join_column_b = column_on_db_b;
      return this;
    }
  
    order(order, column_name) {
      this.order_direction = order;
      this.order_column = column_name;
      return this;
    }
  
    insert(table_name) {
      this.table_name = table_name;
      return this;
    }
  
    values(data) {
      this.insert_data = data;
      return this;
    }
  
    update(table_name) {
      this.table_name = table_name;
      return this;
    }
  
    set(data) {
      this.update_data = data;
      return this;
    }
  
    delete() {
      this.delete_flag = true;
      return this;
    }
  
    run() {
      let result = [];
  
      if (this.delete_flag) {
        // Perform delete operation
        // ...
      } else {
        // Perform select operation
        // ...
  
        if (this.join_table) {
          // Perform join operation
          // ...
        }
  
        if (this.conditions.length > 0) {
          // Apply conditions
          // ...
        }
  
        if (this.order_column) {
          // Apply ordering
          // ...
        }
      }
  
      return result;
    }
  }