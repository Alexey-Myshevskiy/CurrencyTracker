class CountriesUser < ActiveRecord::Base
  attr_accessible :country_code, :user_id
  belongs_to :country, foreign_key: "country_code"
  belongs_to :user


  def self.update_status(user, country_code)
    record=CountriesUser.where("user_id= ? AND country_code=?", user.id, country_code)
    if record.size>0 # если пользователь посещал страну раньше
      record.destroy_all # и снял отметку
    else
      self.new(:user_id => user.id, :country_code => country_code).save # пользователь отметил страну, как посещённую
    end
  end

  def self.count_of_visits_by_date(user,date)
    self.where("user_id=? AND created_at like ?",user.to_s,"%#{date}%").size
  end
end
