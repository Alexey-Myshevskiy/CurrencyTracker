class CurrenciesController < ApplicationController
  before_filter :authenticate_user!
  # GET /currencies
  # GET /currencies.xml
  def index
    @currencies = Currency.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @currencies }
      @currency_f=Currency.new
    end
  end

  # GET /currencies/1
  # GET /currencies/1.xml
  def show
    @currency = Currency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @currency }
    end
  end

  def create
        currencies=params[:country]
        currencies.each do|i|
              if !CountriesUser.visited?(current_user, i) # проверка на существование данной записи в базе 
                CountriesUser.new(:user_id=>current_user,:country_code=>i).save #? puts"== succesfully created===" : puts"== error has occurred==" #если её ещё нет, то сохраняем
            end
        end
        redirect_to Currency
  end
end