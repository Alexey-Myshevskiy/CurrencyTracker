class CountriesUsersController < ApplicationController
	before_filter :authenticate_user!
    def create
        user=params[:countries_user][:user]
        countries=params[:country]
        if !countries.nil?
            countries.each do|elm|
                  if !CountriesUser.visited?(current_user,elm) # проверка на существование данной записи в базе
                    CountriesUser.new(:user_id=>current_user,:country_code=>elm).save #? true : false #если её ещё нет, то сохраняем
                end
            end
            redirect_to Country
        else
          render text: "<html><body><h1  style='color:red;position:center'>Error!</h1></body></html>".html_safe
        end
    end
end
