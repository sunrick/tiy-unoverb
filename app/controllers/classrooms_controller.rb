class ClassroomsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]

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
  end

  def delete
  end
    
  def show_classroom
    @classroom = Classroom.find(params[:id])
    @language = @classroom.language
    @teachers = @classroom.users.where(roles: {role: "teacher"})
    @students = @classroom.users.where(roles: {role: "student"})
    if can? :user_classrooms, @classroom
      render 'detailed_classroom.json.jbuilder', status: :ok
    else
      render 'basic_classroom.json.jbuilder', status: :ok
    end
  end

  def get_classrooms
    @language = Language.find_by(name: params[:language])
    if @language
      if params[:sort_by] == "new"
        @classrooms = @language.classrooms.order(created_at: :desc)
        render 'classrooms.json.jbuilder'
      elsif params[:sort_by] == "top"
        @classrooms = @language.classrooms.order(roles_count: :desc)
        render 'classrooms.json.jbuilder'
      else
        render json: { message: "Not a valid sort_by parameter."},
          status: :unprocessable_entity
      end
    else
      render json: { message: "Language does not exist."},
        status: :unprocessable_entity
    end
  end

end