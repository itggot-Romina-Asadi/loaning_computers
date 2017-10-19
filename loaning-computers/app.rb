require 'sinatra'
require 'sqlite3'

get('/') do
    erb(:index)
end

get('/all_students') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    result = db.execute("SELECT * FROM students")
    erb(:all_students, locals:{ students:result} )
end

post('/students/find_by_id') do
    redirect("/students/by_id/" + params["student_id"])
end

get('/students/by_id/:id') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    student_id = params[:id]
    result = db.execute("SELECT * FROM students WHERE id="+student_id)
    result = result[0]
    erb(:students, locals:{ student:result} )
end

post('/students/find_by_name') do
    redirect("/students/by_name/" + params["student_name"])
end

# Fixa loop så den får fram alla som heter samma
get('/students/by_name/:name') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    student_name = params[:name]
    result = db.execute("SELECT * FROM students WHERE name LIKE '%"+student_name+"%'")
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
    redirect('/students/by_id/'+student_id)
end

post('/students/create') do
    redirect("/students/" + "create/" + params["new_name"] + "/" + params["new_pnr"])
end

get('/students/create/:name/:pnr') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    new_name = params[:name]
    new_pnr = params[:pnr]
    db.execute("INSERT INTO students (name, pnr) VALUES (?, ?)", [new_name, new_pnr])
    student_id = db.execute("SELECT MAX(id) FROM students")
    student_id = student_id[0][0].to_s
    redirect('/students/by_id/'+student_id)
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

get('/all_computers') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    result = db.execute("SELECT * FROM computers")
    erb(:all_computers, locals:{ computers:result} )
end

#Visa namn på elev som äger datorn
post('/computers/find_by_id') do
    redirect("/computers/by_id/" + params["computer_id"])
end

get('/computers/by_id/:id') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    computer_id = params[:id]
    result = db.execute("SELECT * FROM computers WHERE id="+computer_id)
    result = result[0]
    erb(:computers, locals:{ computer:result} )
end

post('/computers/find_by_model') do
    redirect("/computers/by_model/" + params["computer_model"])
end

get('/computers/by_model/:model') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    computer_model = params[:model]
    computer_id = db.execute("SELECT id FROM computer_models WHERE model LIKE '%"+computer_model+"%'")
    computer_id = computer_id[0][0].to_s
    result = db.execute("SELECT * FROM computers WHERE model_id="+computer_id)
    erb(:computers, locals:{ computer:result} )
end

get('/computers_create') do
    erb(:computers_create)
end

post('/computers_create') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    serial_no = params["serial-no"]
    model_id = params["model-id"]
    student_id = params["student-id"]
    db.execute("INSERT INTO computers(serial, model_id, student_id) VALUES(?,?,?)", [serial_no, model_id, student_id])
    computer_id = db.execute("SELECT MAX(id) FROM computers")
    computer_id = computer_id[0][0].to_s
    redirect("/computers/by_id/#{computer_id}")
end

post('/computers/delete') do
    redirect("/computers/" + params["computer_id"] + "/delete")    
end

get('/computers/:id/delete') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    computer_id = params[:id]
    db.execute("DELETE FROM computers WHERE id="+computer_id)
    redirect('/')
end

post('/computers/update') do
    redirect("/computers/" + params["computer_id"] + "/update/" + params["new_serial"] + "/" + params["new_model_id"] + "/" + params["new_student_id"])
end

get('/computers/:id/update/:serial/:model_id/:student_id') do
    db = SQLite3::Database.new("computers_and_loans.sqlite")
    computer_id = params[:id]
    new_student_id = params[:student_id]
    new_serial = params[:serial]
    new_model_id = params[:model_id]
    # db.execute("UPDATE students SET name="+new_name+"WHERE id="+student_id)
    db.execute("UPDATE computers SET serial=?, model_id=?, student_id=? WHERE id=?", new_serial, new_model_id, new_student_id)
    redirect('/computers/by_id/'+computer_id)
end