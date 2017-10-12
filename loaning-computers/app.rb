require 'sinatra'
require 'sqlite3'

get('/') do
    erb(:index)
end

get('/students/:id') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    student_id = params[:id]
    result = db.execute("SELECT * FROM students WHERE id="+student_id)
    result = result[0]
    erb(:students, locals:{ student:result} )
end

get('/students/:id/update') do

end

get('/students/:id/delete') do

end

get('/students/create') do

end

post('/students/:id/update') do

end

post('/students/:id/delete') do

end

post('/students/create') do

end
