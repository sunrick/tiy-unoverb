class RequestsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]



end