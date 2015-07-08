class ClassroomsController < ApplicationController

  def create
    @language = Language.find_by(name: params[:language])
    @classroom = current_user.classrooms.new( name: params[:name], 
                                              description: params[:description], 
                                              language: @language.id )
    authorize! :create, @classroom
    @classroom.save
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