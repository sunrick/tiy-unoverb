class ClassroomsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :request_join, :show_user_classrooms]

  def create
    @language = Language.find_by(name: params[:language])
    if @language
      @classroom = current_user.classrooms.new( name: params[:name], 
                                                description: params[:description], 
                                                language: @language,
                                                avatar: params[:avatar] )
      if @classroom.save
        @role = Role.create( user: current_user, classroom: @classroom, role: "teacher" )
        @user = current_user
        render 'created.json.jbuilder', status: :created
      else
        render json: { errors: @classroom.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Language doesn't exist"}, status: :unprocessable_entity
    end
  end

  def update
    @language = Language.find_by(name: params[:language])
    classroom_params = { name: params[:name], 
                         description: params[:description],
                         avatar: params[:avatar],
                         language: @language }
    @classroom = Classroom.find(params[:id])
    @role = Role.find_by(user: current_user, classroom: @classroom)
    @user = current_user
    authorize! :update, @classroom
    @classroom.update(classroom_params)
    render 'created.json.jbuilder', status: :ok
  end

  def delete
    @classroom = Classroom.find(params[:id])
    authorize! :delete, @classroom
    @classroom.destroy
    render json: { message: "Classroom deleted." }, status: :ok
  end
    
  def show_classroom
    @classroom = Classroom.find(params[:id])
    @language = @classroom.language
    @teachers = @classroom.users.where(roles: {role: "teacher"})
    @students = @classroom.users.where(roles: {role: "student"})
    if can? :show_classroom, @classroom
      render 'detailed_classroom.json.jbuilder', status: :ok
    else
      render 'basic_classroom.json.jbuilder', status: :ok
    end
  end

  def show_user_classrooms
    @teacher_classrooms = current_user.classrooms.where(roles: {role: "teacher"})
    @student_classrooms = current_user.classrooms.where(roles: {role: "student"})
    render 'user_classrooms.json.jbuilder'
  end

  def get_classrooms
    @language = Language.find_by(name: params[:language])
    if @language
      if params[:sort_by] == "new"
        @classrooms = @language.classrooms.order(created_at: :desc).page(params[:page])
        render 'classrooms.json.jbuilder', status: :ok
      elsif params[:sort_by] == "top"
        @classrooms = @language.classrooms.order(roles_count: :desc).page(params[:page])
        render 'classrooms.json.jbuilder', status: :ok
      else
        render json: { message: "Not a valid sort_by parameter."},
          status: :unprocessable_entity
      end
    else
      render json: { message: "Language does not exist."},
        status: :unprocessable_entity
    end
  end

  def request_join
    @classroom = Classroom.find(params[:id])
    @request = Request.find_by(user: current_user, classroom: @classroom)
    if @request.nil? && !@classroom.roles.find_by(user: current_user)
      @request = Request.new(user: current_user, classroom: @classroom, message: params[:message], role: params[:role])
      if @request.save
        @user = current_user
        render 'request.json.jbuilder', status: :created
      else
       render json: { errors: @request.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "You have already tried to join this class or you are already part of it."}, status: :unprocessable_entity
    end
  end

  def get_requests
    @classroom = Classroom.find(params[:id])
    authorize! :get_requests, @classroom
    @requests = @classroom.requests.all
    render 'requests.json.jbuilder', status: :ok
  end

  def process_request
    @request = Request.find(params[:id])
    @classroom = @request.classroom
    authorize! :process_request, @classroom
    if params[:accept] == "yes"
      @user = @request.user
      @role = Role.create(user: @user, classroom: @classroom, role: @request.role)
      render 'request_process.json.jbuilder'
      @request.destroy
    elsif params[:accept] == "no"
      @request.destroy
      render json: { message: "Request deleted."}
    else
      render json: { message: "Check your accept parameter."}
    end
  end

end