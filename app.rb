require 'sinatra'
require 'sqlite3'
require 'slim'
require 'sinatra/reloader'




# Routen /
get('/') do
    db = SQLite3::Database.new('db/todos.db') # Öppnar datanas
    db.results_as_hash = true #Begär hash

    @postitall = db.execute("SELECT * FROM todos")
    @postit = db.execute("SELECT * FROM todos WHERE done = false")
    @postitdone = db.execute("SELECT * FROM todos WHERE done = true")

    @cats = []
    @postitall.each do |post|
      onecat = db.execute("SELECT cat_id FROM todos LEFT JOIN todo_cat ON todos.id = todo_cat.todo_id WHERE  id = ?", post["id"])
      @cats.concat([onecat])
    end
    slim(:index)
end


post('/add') do
  namnet = params[:name]
  desc = params[:description]
  categ = params[:kat]
  db = SQLite3::Database.new('db/todos.db') # Öppnar datanas
  db.results_as_hash = true #Begär hash

  @postit = db.execute("INSERT INTO todos (name, description, category, done) VALUES (?,?,?, false)",[ namnet, desc, categ]) # Tar ut datan, förvarar i @animals

  redirect('/')
end


get('/edit/:id') do
  db = SQLite3::Database.new('db/todos.db') # Öppnar datanas
  db.results_as_hash = true #Begär hash
  id = params[:id]

  @postitnote = db.execute("SELECT * FROM todos WHERE id = ?", id).first

  slim(:edit)
end

post('/edit/:id') do
  id = params[:id]
  name = params[:name]
  desc = params[:description]
  db = SQLite3::Database.new('db/todos.db') # Öppnar datanas
  db.results_as_hash = true #Begär hash

  db.execute("UPDATE todos 
              SET name = ?, description = ?
              WHERE id = ?", 
              [name, desc, id])
  redirect('/')
end


post('/delete/:id') do
  id = params[:id]
  db = SQLite3::Database.new('db/todos.db') # Öppnar datanas
  db.results_as_hash = true #Begär hash

  db.execute("DELETE FROM todos WHERE id = ?", id)
  db.execute("DELETE FROM todo_cat WHERE todo_id = ?", id)

  redirect('/')
end

post('/doneify/:id') do
  id = params[:id]
  db = SQLite3::Database.new('db/todos.db') # Öppnar datanas
  db.results_as_hash = true #Begär hash

  db.execute("UPDATE todos SET done = true WHERE id = ?", id)
  redirect('/')
end

post('/undoneify/:id') do
  id = params[:id]
  db = SQLite3::Database.new('db/todos.db') # Öppnar datanas
  db.results_as_hash = true #Begär hash

  db.execute("UPDATE todos SET done = false WHERE id = ?", id)
  redirect('/')
end