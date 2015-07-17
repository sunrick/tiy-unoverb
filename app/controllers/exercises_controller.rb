class ExercisesController < ApplicationController
  before_action :authenticate_with_token!
  def create
    @classroom = Classroom.find(params[:id])
    @exercise = @classroom.exercises.new( name: params[:name], 
                                          description: params[:description])
    authorize! :create, @exercise
    if @exercise.save
      render 'created.json.jbuilder', status: :created
    else
      render json: { errors: @exercise.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def get_exercises
    @classroom = Classroom.find(params[:id])
    authorize! :get_exercises, @classroom
    @exercises = @classroom.exercises.all
    render "exercises.json.jbuilder", status: :ok
  end

  def get_exercise
    @exercise = Exercise.find(params[:id])
    @classroom = @exercise.classroom
    authorize! :get_exercise, @exercise
    render 'exercise.json.jbuilder', status: :ok
  end

  def delete
    @exercise = Exercise.find(params[:id])
    authorize! :delete, @exercise
    @exercise.destroy
    render json: { message: "Exercise destroyed." }, status: :ok
  end

  def update
    @exercise = Exercise.find(params[:id])
    @classroom = @exercise.classroom
    authorize! :update, @exercise
    exercise_params = {
      name: params[:name],
      description: params[:description]
    }
    @exercise.update(exercise_params)
    render 'created.json.jbuilder', status: :ok
  end

end