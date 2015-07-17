class TensesController < ApplicationController
  before_action :authenticate_with_token!

  def get_tenses
    @language = Language.find_by!(name: params[:language])
    @tenses = @language.tenses.all
    render 'tenses.json.jbuilder'
  end

end