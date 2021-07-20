class ApplicationController < ActionController::Base
  before_action :authenticate_user! # For devise
end
