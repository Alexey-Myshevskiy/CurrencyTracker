class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @countries = Country.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end
  def signup

  end
end
