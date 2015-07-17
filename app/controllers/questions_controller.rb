class QuestionsController < ApplicationController

  def create
    questions = params[:data]
    questions.each do |q|
      @verb = Verb.find_by(verb: q[:verb])
      @tense = Tense.find_by(combined_tense_english: q[:combined_tense_english])
      @form = Form.find_by(form: q[:form])
      @conjugation = Conjugation.find_by!(verb: @verb, tense: @tense, form: @form)
      @question = @conjugation.questions.create(exercise_id: params[:id])
    end
    render json: @question
  end

end