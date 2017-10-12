require 'sinatra'
require 'sqlite3'

get('/') do
    erb(:index)
end

post('/students/find_by_id') do
    redirect("/students/" + params["student_id"])
end

get('/students/:id') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    student_id = params[:id]
    result = db.execute("SELECT * FROM students WHERE id="+student_id)
    result = result[0]
    erb(:students, locals:{ student:result} )
end

get('/students/:id/update') do
    db = SQLite3::Database.new("computers_and_loans_sqlite")
    student_id = params[:id]
    new_name = params[:name]
    new_pnr = params[:pnr]
    result = db.execute("UPDATE students SET name="+new_name "AND pnr="+new_pnr "WHERE id="+student_id)

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
