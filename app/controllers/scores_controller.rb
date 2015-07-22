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
    attempts = @question.solutions.count
    correct = @question.solutions.where(correct: true).count
    wrong = attempts - correct
    common_mistakes = Solution.where(question: @question, correct: false)
                              .group(:guess).limit(5).count
                              .to_a
    @users = User.joins(:solutions)
                 .where(solutions: {question_id: @question.id})
                 .group(:id)
    @user_scores = []
    @users.each do |user|
      solutions = Solution.joins(:user).where(users: {id: user.id})
      attempts = solutions.count
      correct = solutions.where(correct: true).count
      common_mistakes = solutions.where(correct: false).group(:guess).limit(5).count.to_a
      result = {
        user: user,
        attempts: attempts,
        correct: correct,
        wrong: attempts - correct,
        accuracy: (correct.to_f / attempts.to_f) * 100,
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
      attempts: attempts,
      correct: correct,
      wrong: wrong,
      accuracy: (correct.to_f / attempts.to_f) * 100,
      common_mistakes: common_mistakes,
      user_scores: @user_scores
    }
    render "question.json.jbuilder"
  end

  def classroom
    @classroom = Classroom.find(params[:id])
    @exercises = @classroom.exercises.all
    Solution.joins(:game)
  end

  def user
  end

  def game
  
  end

end