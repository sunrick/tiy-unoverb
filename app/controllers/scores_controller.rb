class ScoresController < ApplicationController
  before_action :authenticate_with_token!

  def exercise
    @exercise = Exercise.find(params[:id])
    authorize! :exercise, @exercise
    @questions = @exercise.questions
    @results = []
    @questions.each do |q|
      conjugation = q.conjugation
      verb = conjugation.verb
      tense = conjugation.tense
      form = conjugation.form
      attempts = q.solutions.count
      correct = q.solutions.where(correct: true).count
      wrong = attempts - correct
      common_mistakes = Solution.where(question: q, correct: false)
                                .group(:guess).limit(5).count
                                .to_a
      top_time = q.solutions.minimum(:time)
      slowest_time = q.solutions.maximum(:time)
      avg_time = q.solutions.sum(:time).to_f / attempts.to_f
      result = {
        question: q,
        conjugation: conjugation,
        verb: verb,
        tense: tense,
        form: form,
        attempts: attempts,
        correct: correct,
        wrong: wrong,
        accuracy: (correct.to_f / attempts.to_f) * 100,
        top_time: top_time,
        slowest_time: slowest_time,
        avg_time: avg_time,
        common_mistakes: common_mistakes
      }
      @results << result
    end
    render 'exercise.json.jbuilder'
  end

  def question
    @question = Question.find(params[:id])
    @exercise = @question.exercise
    authorize! :question, @exercise
    conjugation = @question.conjugation
    verb = conjugation.verb
    tense = conjugation.tense
    form = conjugation.form
    @attempts = @question.solutions.count
    @correct = @question.solutions.where(correct: true).count
    @wrong = @attempts - @correct
    @top_time = @question.solutions.minimum(:time)
    @slowest_time = @question.solutions.maximum(:time)
    @avg_time = @question.solutions.sum(:time).to_f / @attempts.to_f
    @common_mistakes = Solution.where(question: @question, correct: false)
                              .group(:guess).limit(5).count
                              .to_a
    @users = User.joins(:solutions)
                 .where(solutions: {question_id: @question.id})
                 .group(:id)
    @user_scores = []
    @users.each do |user|
      solutions = @question.solutions.joins(:user).where(users: {id: user.id})
      attempts = @question.solutions.count
      correct = @question.solutions.where(correct: true).count
      common_mistakes = @question.solutions.where(correct: false, user_id: user.id).group(:guess).limit(5).count.to_a
      top_time = @question.solutions.minimum(:time)
      slowest_time = @question.solutions.maximum(:time)
      avg_time = @question.solutions.sum(:time).to_f / attempts.to_f
      result = {
        user: user,
        attempts: attempts,
        correct: correct,
        wrong: attempts - correct,
        accuracy: (correct.to_f / attempts.to_f) * 100,
        top_time: top_time,
        slowest_time: slowest_time,
        avg_time: avg_time,
        common_mistakes: common_mistakes
      }
      @user_scores << result
    end
    @result = {
      question: @question,
      conjugation: conjugation,
      verb: verb,
      tense: tense,
      form: form,
      attempts: @attempts,
      correct: @correct,
      wrong: @wrong,
      accuracy: (@correct.to_f / @attempts.to_f) * 100,
      top_time: @top_time,
      slowest_time: @slowest_time,
      avg_time: @avg_time,
      common_mistakes: @common_mistakes,
      user_scores: @user_scores
    }
    render "question.json.jbuilder"
  end

  # def classroom
  #   @classroom = Classroom.find(params[:id])
  #   @exercises = @classroom.exercises.all
  #   Solution.joins(:game)
  # end

  # def users
  #   @exercise = Exercise.find(params[:id])
  #   @users = @exercise.users.group(:id)
  #   @results = []
  #   @users.each do |user|
  #     @games = user.games.where(exercise_id: @exercise.id)
  #     attempts = @games.solutions.count
  #     correct = @games.solutions.where(correct: true}).count
  #     wrong = attempts - wrong
  #     accuracy = (correct.to_f / attempts.to_f) * 100
  #     top_time = @games.solutions.minimum(:time)
  #     slowest_time = @games.solutions.maximum(:time)
  #     avg_time = @games.solutions.sum(:time).to_f / attempts.to_f

  #     result = {
  #       user: user,
  #       games_count: @games.count,
  #       attempts: attempts,
  #       correct: correct,
  #       wrong: wrong,
  #       accuracy: accuracy,
  #       top_time: top_time,
  #       slowest_time: slowest_time,


  #       games:
  #     }
  #     @results << result
  #   end
  #   @results
  #   render json: @results
  # end

  # def user
  #   @user = User.find(params[:id])
  #   @games = Game.joins(:user, :exercise).where(exercises: { id: id})
  # end

  def game
    @game = Game.find(params[:id])
    @solutions = @game.solutions
    @solution_scores= []
    @solutions.each do |solution|
      conjugation = solution.conjugation
      result = {
        question: solution.question,
        conjugation: conjugation,
        verb: conjugation.verb,
        tense: conjugation.tense,
        form: conjugation.form,
        correct: solution.correct,
        time: solution.time
      }
      @solution_scores << result
    end
    attempts = @solutions.count
    correct =  @solutions.where(correct: true).count
    wrong = attempts - correct
    accuracy = (correct.to_f / attempts.to_f) * 100
    top_time = @solutions.minimum(:time)
    slowest_time = @solutions.maximum(:time)
    avg_time = @solutions.sum(:time).to_f / attempts.to_f
    @result = {
      game: @game,
      user: @game.user,
      attempts: attempts,
      correct: correct,
      wrong: wrong,
      accuracy: accuracy,
      top_time: top_time,
      slowest_time: slowest_time,
      avg_time: avg_time,
      solution_scores: @solution_scores
    }
    render "game.json.jbuilder"
  end

end