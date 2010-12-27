class TodosController < ApplicationController
  # GET /todos
  # GET /todos.xml
  def index
    @todo = Todo.new
    @user = User.find_by_id(session[:user_id])
    if @user.doing.present?
      begin
        @doing = Todo.find(@user.doing)
      rescue
        @user.doing = nil
        @user.save
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @todos }
    end
  end
  
  def list
    @user = User.find_by_id(session[:user_id])
    @todos = @user.todos
  end
  
  # GET /todos/dosomething
  def dosomething
    if params[:todo].present? && params[:todo][:time].present?
      todos = Todo.find(:all, :conditions => [ "time <= ? AND user_id = ?", params[:todo][:time], session[:user_id]])
    elsif params[:todo_id].present?
      todos = Todo.where(:id => params[:todo_id], :user_id => session[:user_id])
    else
      todos = Todo.find(:all, :conditions => [ "user_id = ?", session[:user_id]])
    end
    todo = todos[rand(todos.count)]
    
    if todo.present? then
      @user = User.find_by_id(session[:user_id])
      @user.doing = todo.id
      @user.save
      redirect_to todos_url
    else
      if Todo.where(:user_id => session[:user_id]).count > 0
        redirect_to todos_url, :notice => "There is nothing you can do in this time"
      else
        redirect_to todos_url, :notice => "You have nothing to do!"
      end
    end
    
  end
  
  def done
    @user = User.find_by_id(session[:user_id])
    Todo.destroy(@user.doing)
    @user.doing = nil
    @user.save
    
    redirect_to todos_url, :notice => "Well done!"
  end
  
  def later
    @user = User.find_by_id(session[:user_id])
    @user.doing = nil
    @user.save
    redirect_to todos_url
  end
  
  # GET /todos/1
  # GET /todos/1.xml
  def show
   @todo = Todo.where(:id => params[:id], :user_id => session[:user_id]).first  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.xml
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.where(:id => params[:id], :user_id => session[:user_id]).first
  end

  # POST /todos
  # POST /todos.xml
  def create
    puts ""
    puts "test"
    puts params[:description]
    puts "test"
    @todo = Todo.new(:description => params[:todo][:description], :time => params[:todo][:time], :user_id => session[:user_id])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to(todos_url, :notice => "Got it, you need to <b>#{@todo.tpdescription} </b>. To→done will remind you of this later.".html_safe) }
        format.xml  { render :xml => @todo, :status => :created, :location => @todo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.xml
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to(@todo, :notice => 'Todo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.xml
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'todos', :action => "list" }
      format.xml  { head :ok }
    end
  end
end
