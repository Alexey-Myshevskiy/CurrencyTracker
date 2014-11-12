class CountriesUsersController < ApplicationController
	before_filter :authenticate_user!
    def create
      @countries = Country.find params[:country]
      @target = params[:target] == 'currencies' ? 'currencies' : 'countries'
          user=params[:countries_user][:user]

        @countries.each do|elm|
                  if !CountriesUser.visited?(current_user,elm) # проверка на существование данной записи в базе
                    CountriesUser.new(:user_id=>current_user.email,:country_code=>elm).save  #если её ещё нет, то сохраняем
                  else
                    next # переход к следующей итерации, если елемент уже есть в базе
                end
            end
            respond_to do |format|
            #  format.html { redirect_to @countries_user, notice: 'User was successfully created.' }
              format.js   {}
            end
    end
end
