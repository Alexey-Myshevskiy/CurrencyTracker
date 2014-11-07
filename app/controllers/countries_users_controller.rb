class CountriesUsersController < ApplicationController
    def create
        user=params[:countries_user][:user]
        countries=params[:country]
        countries.each{|elm| CountriesUser.new(:user_id=>user,:country_code=>elm).save}
        redirect_to Country
    end
end
