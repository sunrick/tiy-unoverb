class QuestionsController < ApplicationController
  before_action :authenticate_with_token!

  def create
    questions = params[:data]
    if !params[:data].nil?
      @exercise = Exercise.find(params[:id])
      authorize! :create, @exercise
      @language = @exercise.classroom.language
      @results = []
      ActiveRecord::Base.transaction do
        questions.each do |q|
          @verb = @language.verbs.find_by!(verb: q[:verb])
          @tense = @language.tenses.find_by!(combined_tense_english: q[:combined_tense_english])
          @form = @language.forms.find_by!(form: q[:form])
          @conjugation = Conjugation.find_by!(verb: @verb, tense: @tense, form: @form)
          @question = Question.find_or_create_by(exercise: @exercise, conjugation: @conjugation)
          @results << { question: @question, 
                        verb: @verb, 
                        tense: @tense, 
                        form: @form, 
                        conjugation: @conjugation }
        end
      end
      render 'questions.json.jbuilder', status: :created
    else
      render json: { message: "Data param is empty." }
    end
  end

  def get_questions
    @exercise = Exercise.find(params[:id])
    authorize! :get_questions, @exercise
    @results = []
    @exercise.questions.each do |q|
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
    render 'questions.json.jbuilder', status: :ok
  end

  def get_question
    @question = Question.find(params[:id])
    @exercise = @question.exercise
    authorize! :get_question, @exercise
    @result = {
      question: @question,
      verb: @question.conjugation.verb,
      tense: @question.conjugation.tense,
      form: @question.conjugation.form,
      conjugation: @question.conjugation
    }
    render 'question.json.jbuilder', status: :ok
  end

  def delete
    @question = Question.find(params[:id])
    @exercise = @question.exercise
    authorize! :delete, @exercise
    @question.destroy
    render json: {message: "Question has been destroyed."}, status: :ok
  end

  def update
    @question = Question.find(params[:id])
    @exercise = @question.exercise
    authorize! :update, @exercise
    @language = @exercise.classroom.language
    @verb = @language.verbs.find_by!(verb: params[:verb])
    @tense = @language.tenses.find_by!(combined_tense_english: params[:combined_tense_english])
    @form = @language.forms.find_by!(form: params[:form])
    @conjugation = Conjugation.find_by!(verb: @verb, tense: @tense, form: @form)

    @question.update(conjugation: @conjugation)
    @result = {
      question: @question,
      verb: @verb,
      tense: @tense,
      form: @form,
      conjugation: @conjugation
    }
    render 'question.json.jbuilder', status: :ok
  end

end