class VerbsController < ApplicationController
  # before_action :authenticate_with_token!

  def search
    @language = Language.find_by!(name: params[:language])
    @verbs = @language.verbs.where("verb like ?", "%#{params[:search]}%")
    render 'verbs_search.json.jbuilder', status: :ok
  end

end