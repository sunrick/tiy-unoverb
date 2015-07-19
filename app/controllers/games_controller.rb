class GamesController < ApplicationController

  def save

  end

  def play
    @exercise = Exercise.find(params[:id])
    @questions = @exercise.questions.all.shuffle
    @results = []
    @questions.each do |q|
      @question = q
      @verb = q.conjugation.verb
      @tense = q.conjugation.tense
      @form = q.conjugation.form
      @conjugation = q.conjugation
      @results << { question: @question, 
                    verb: @verb, 
                    tense: @tense, 
                    form: @form, 
                    conjugation: @conjugation }
    end
    render 'play.json.jbuilder'
  end

  def get_game
  end

end