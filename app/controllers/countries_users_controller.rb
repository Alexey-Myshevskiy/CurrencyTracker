class CountriesUsersController < ApplicationController
	before_filter :authenticate_user!
    def create
      @countries = Country.find params[:country]
      @currencies= Currency.where(country_id:params[:country])
      @target = params[:countries_user][:target] == 'currencies' ? 'currencies' : 'countries'
          user=params[:countries_user][:user]
        @countries.each do|elm|
                  if !current_user.visited_this_country?(elm)# проверка на существование данной записи в базе
                    CountriesUser.new(:user_id=>current_user.id,:country_code=>elm).save  #если её ещё нет, то сохраняем
                  else
                    next # переход к следующей итерации, если елемент уже есть в базе
                end
            end
            respond_to do |format|
              format.js   {}
            end
    end
end
