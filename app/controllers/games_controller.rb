class GamesController < ApplicationController
  before_action :authenticate_with_token!
  
  def save
    @exercise = Exercise.find(params[:id])
    authorize! :save, @exercise
    solutions = params[:data]
    @game = Game.create(user: current_user, exercise: @exercise)
    @results = []
    ActiveRecord::Base.transaction do
      solutions.each do |s|
        @question = Question.find(s[:question_id])

        conjugation = @question.conjugation.conjugation
        # correct = conjugation == s[:guess] ? true : false
        if s[:guess] == conjugation
          @solution = Solution.create!( question: @question,
                                        game: @game,
                                        time: s[:time],
                                        guess: s[:guess],
                                        correct: true
                                      )
        elsif s[:guess] != conjugation
          @solution = Solution.create!( question: @question,
                                        game: @game,
                                        time: s[:time],
                                        guess: s[:guess]
                                      )
        end
      end
    end
    render json: { game_id: @game.id}, status: :created
  end

  def play
    @exercise = Exercise.find(params[:id])
    authorize! :play, @exercise
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
    render 'play.json.jbuilder', status: :ok
  end

end