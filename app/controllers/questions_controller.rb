class QuestionsController < ApplicationController

  def create
    @test = params[:test]
    render json: @test
  end

end