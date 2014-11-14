class CurrenciesController < ApplicationController
  before_filter :authenticate_user!
  # GET /currencies
  # GET /currencies.xml
  def index
    @currencies = Currency.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @currencies }
      @countries_user=CountriesUser.new
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
    if !currencies.nil?
      currencies.each do |i|
        if !current_user.visited_this_country?(i) # проверка на существование данной записи в базе
          CountriesUser.new(:user_id => current_user.email, :country_code => i).save # если нет, то сохраняем
        else
          next # иначе пропускаем существующие записи, и переходим к следующей итерации
        end
      end
      respond_to do |format|
        format.js   {}
        format.json { render json:@currency_f, status: :created, location:@currency_f }
      end
    else
      # Show ERROR massage
    end
  end
end