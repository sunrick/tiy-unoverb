class ClassroomsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]

  def create
    @language = Language.find_by(name: params[:language].downcase)
    if @language
      @classroom = current_user.classrooms.new( name: params[:name], 
                                                description: params[:description], 
                                                language: @language,
                                                code: params[:code] )
      authorize! :create, @classroom
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
    
  def show
    @classroom = current_user.classrooms.find(1)
    authorize! :show, @classroom
  end

end