class QuestionsController < ApplicationController

  def create
    @test = params[:data]
    render json: @test
  end

end