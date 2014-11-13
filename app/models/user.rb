class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :countries_users
  has_many :countries, :through=>:countries_users
  @count=0 # хранит общее количество посещённых стран
  @total_amount=0 # хранит количество стран в базе
 @b=0
  @b1=0

  # получить для пользователя количество стран, где он побывал
  def count_of_visited_countries
    @count=CountriesUser.where(:user_id =>id).size
  end

  def count_of_unvisited_countries
    # получим сначала общие количество стран
      @total_amount=Country.all.size
    # результатом будет количество не посещённых стран
      if @total_amount>0
        @total_amount-@count
      else
        # ERROR MUST FIRED!
        end
  end

  def visited_this_country?(country_code)
    bool=CountriesUser.where("user_id= ? AND country_code=?", id, country_code)
    bool.size>0 ? true : false
  end

  def prepare_graphic_data
    result_array=Array.new
    result_array.push(["data","visits"])
    u=CountriesUser.select('created_at').where(:user_id=>id) # получили все даты посещения для пользователя
    if u.size>0
      @b=u.map{|i| i.created_at.to_date} # преобразуем временную метку в дату
      @b1=@b.uniq #содержит уникальные даты
      @b1.each do |j|
        result_array.push( [j.to_s,@b.count(j)] ) # сроим массив для инициализации графика
      end
      return result_array
    else # если пользователь ещё не посещал ни одну страну
      result_array.push( [Date.today.to_s,0] ) # сроим массив для инициализации графика
      end
  end

  def prepare_range
    range=Array.new

    if (!@b1.nil? && @b1.size>10)
      range.push(0) # диапазон должен начинаться с нуля
      @b1.each do |j|
        range.push(@b.count(j)) # строим диапазон
      end
      range=range.sort!
      (0..(range.last+3)).to_a
    else
      (0..5).to_a
      end
  end

end
