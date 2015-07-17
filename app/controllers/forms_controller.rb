class FormsController < ApplicationController
  before_action :authenticate_with_token!

   def get_forms
    @language = Language.find_by!(name: params[:language])
    @forms = @language.forms.all
    render 'forms.json.jbuilder'
  end

end