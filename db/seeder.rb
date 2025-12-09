require 'sqlite3'

db = SQLite3::Database.new("db/todos.db")


def seed!(db)
  puts "Using db file: db/todos.db"
  puts "🧹 Dropping old tables..."
  drop_tables(db)
  puts "🧱 Creating tables..."
  create_tables(db)
  puts "🍎 Populating tables..."
  populate_tables(db)
  puts "✅ Done seeding the database!"
end

def drop_tables(db)
  db.execute('DROP TABLE IF EXISTS todos')
  db.execute('DROP TABLE IF EXISTS categories')
  db.execute('DROP TABLE IF EXISTS todo_cat')
end

def create_tables(db)
  db.execute('CREATE TABLE todos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL, 
              description TEXT,
              done BOOLEAN)')
  db.execute('CREATE TABLE categories (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL)')
  db.execute('CREATE TABLE todo_cat (
              todo_id INTEGER NOT NULL,
              cat_id INTEGER NOT NULL)')
end

def populate_tables(db)
  db.execute('INSERT INTO todos (name, description, done) VALUES ("Köp mjölk", "3 liter mellanmjölk, eko", false)')
  db.execute('INSERT INTO todos (name, description, done) VALUES ("Köp julgran", "En rödgran", false)')
  db.execute('INSERT INTO todos (name, description, done) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten", true)')
  db.execute('INSERT INTO categories (name) VALUES ("Bråttom")')
  db.execute('INSERT INTO categories (name) VALUES ("Greta Gris")')
  db.execute('INSERT INTO categories (name) VALUES ("Pengar")')
  db.execute('INSERT INTO categories (name) VALUES ("Jul")')
  db.execute('INSERT INTO categories (name) VALUES ("Vänner")')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (1, 2)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (1, 3)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (1, 5)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (2, 1)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (2, 4)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (2, 5)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (3, 1)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (3, 4)')
  db.execute('INSERT INTO todo_cat (todo_id, cat_id) VALUES (3, 5)')
end

seed!(db)