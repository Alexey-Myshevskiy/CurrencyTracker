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
  total_amount=0 # хранит количество стран в базе

  # получить для пользователя количество стран, где он побывал
  def count_of_visited_countries
    CountriesUser.where(:user_id =>id).size
  end

  def count_of_unvisited_countries
    # получим сначала общие количество стран
      total_amount=Country.all.size
    # результатом будет количество не посещённых стран
      if total_amount>0
        total_amount-count_of_visited_countries
      else
        # ERROR MUST FIRED!
        end
  end

  def visited_this_country?(country_code)
    bool=CountriesUser.where("user_id= ? AND country_code=?", id, country_code)
    bool.size>0 ? true : false
  end

  def prepare_graphic_dates
    counter_of_dates=0
    range=[0]
    # report_data=Hash.new
    result_array=Array.new
    result_array.push(["data", "visits"])
    counter_of_dates=CountriesUser.uniques_date_size(id)

    if counter_of_dates.size>0&&counter_of_dates.size<8
      counter=0
      counter_of_dates.each do |j|
        counter==0 ? counter=CountriesUser.count_of_visits_by_date(id, j) : counter+=CountriesUser.count_of_visits_by_date(id, j)
        range.push(counter)
        result_array.push([j.to_s, counter])
      end
      report_data = {"initialize_x" =>result_array, "initialize_y" =>range}
    elsif counter_of_dates.size>8
      arr=counter_of_dates.grep counter_of_dates.size-7..counter_of_dates.size
      arr.each do |j|
        counter==0 ? count=CountriesUser.count_of_visits_by_date(id, j) : count+=CountriesUser.count_of_visits_by_date(id, j)
        range.push(count)
        result_array.push([j.to_s, count])
      end
      report_data = {"initialize_x" =>result_array, "initialize_y" =>range}
    else # если пользователь ещё не посещал ни одну страну
      range=(0..7).to_a
      result_array.push([Date.today.to_s, 0]) # сроим массив для инициализации графика
      report_data = {"initialize_x" =>result_array, "initialize_y" =>range}
    end
  end

end
