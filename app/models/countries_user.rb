class CountriesUser < ActiveRecord::Base
  attr_accessible :country_code, :user_id
  belongs_to :country, foreign_key: "country_code"
  belongs_to :user
  @@total_of_countries
  @@count

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

  private
  def self.total
    @@total_of_countries=Country.all.size
  end
end
