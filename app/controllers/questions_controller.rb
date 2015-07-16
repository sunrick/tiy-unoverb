class QuestionsController < ApplicationController

  def create
    @test = params[:data]
    binding.pry
    render json: @test
  end

end