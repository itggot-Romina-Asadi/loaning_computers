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

post('/students/update') do
    redirect("/students/" + params["student_id"] + "/update/" + params["new_name"] + "/" + params["new_pnr"])
end

get('/students/:id/update/:name/:pnr') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    student_id = params[:id]
    new_name = params[:name]
    new_pnr = params[:pnr]
    # db.execute("UPDATE students SET name="+new_name+"WHERE id="+student_id)
    db.execute("UPDATE students SET name=?, pnr=? WHERE id=?", new_name, new_pnr, student_id)
    redirect('/students/'+student_id)
end

post('/students/create') do
    redirect("/students/" + "create/" + params["new_name"] + "/" + params["new_pnr"])
end

get('/students/create/:name/:pnr') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    new_name = params[:name]
    new_pnr = params[:pnr]
    db.execute("INSERT INTO students (name, pnr) VALUES (?, ?)", new_name, new_pnr)
    # student_id = db.execute("SELECT MAX(id) FROM students").to_s
    # redirect('/students/'+student_id)
end

post('/students/delete') do
    redirect("/students/" + params["student_id"] + "/delete")    
end

get('/students/:id/delete') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    student_id = params[:id]
    db.execute("DELETE FROM students WHERE id="+student_id)
    redirect('/')
end