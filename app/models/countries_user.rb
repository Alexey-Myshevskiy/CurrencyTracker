class CountriesUser < ActiveRecord::Base
  attr_accessible :country_code, :user_id
  belongs_to :country, foreign_key: "country_code"
  belongs_to :user
  @@total_of_countries=0
  @@count
  @@b1
  @@b
  def self.count_of_visited_countries(user)
    @@count=self.where(:user_id => user.email).size
  end

  def self.count_of_unvisited_countries(user)
    total # получим сначала общие количество стран
    @@total_of_countries-@@count # результатом будет количество не посещённых стран
  end

  def self.visited?(user, country_code)
    bool=self.where("user_id= ? AND country_code=?", user.email, country_code)
    bool.size>0 ? true : false
  end


  def self.update_status(user, country_code)
    record=CountriesUser.where("user_id= ? AND country_code=?", user.email, country_code)
    if record.size>0 # если пользователь посещал страну раньше
      record.destroy_all # и снял отметку
    else
      self.new(:user_id => user.email, :country_code => country_code).save # пользователь отметил страну, как посещённую
    end
  end

  def self.prepare_graphic_data(user)
    result_array=Array.new
      result_array.push(["data","visits"])
    u=self.select('created_at').where(:user_id=>user.email) # получили все посещения для пользователя
    @@b=u.map{|i| i.created_at.to_date} # преобразуем временную метку в дату
    @@b1=@@b.uniq #содержит уникальные даты
      @@b1.each do |j|
        result_array.push( [j.to_s,@@b.count(j)] ) # сроим массив для инициализации графика
      end
    return result_array
  end

  def self.prepare_range # ---------------- сырой нужно править-------------------------
    range=Array.new
    range.push(0)
    @@b1=@@b.uniq #содержит уникальные даты
    @@b1.each do |j|
      range.push(@@b.count(j)) # строим диапазон
    end
    range=range.sort!
    (0..range.last)
    end

  private
  def self.total
    @@total_of_countries=Country.all.size
  end
end
