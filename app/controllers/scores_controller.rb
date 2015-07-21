class ScoresController < ApplicationController

  def exercise
    @questions = Exercise.find(params[:id]).questions
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