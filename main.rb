require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'httparty'
require 'json'
require 'pg'


##List all tasks
get '/list' do
    db = PG.connect(dbname: 'todo_database', host: 'localhost')
    sql = "select task from tasks;"
    @results = db.exec(sql)

erb :list
end


##Create a task
get '/create' do
  if params.any?
    db = PG.connect(dbname: 'todo_database', host: 'localhost')
      @task = params[:task]
      @duedate = params[:duedate]

    sql = "insert into tasks (task, duedate) values ('#{@task}', '#{@duedate}')"

        db.exec(sql)
      end

erb :create
end


#Get a task
get '/get' do
    db = PG.connect(dbname: 'todo_database', host: 'localhost')
    sql = "select task from tasks;"
    @results = db.exec(sql)

    @task = params[:task]
    sql = "select task from tasks where task='#{@task}';"
    @task_got = sql
    puts "#{sql}"

erb :get
end


##Update a task
# get '/update' do
#     db = PG.connect(dbname: 'todo_database', host: 'localhost')
#       sql = "select task from tasks;"
#     @results = db.exec(sql)

# erb :list
# end


##Delete a task
get '/delete' do
    db = PG.connect(dbname: 'todo_database', host: 'localhost')
        @task = params[:task]
    sql = "delete from tasks where task = '#{@task}';"
      @results = db.exec(sql)

erb :delete
end
