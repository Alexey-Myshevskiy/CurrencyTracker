class CountriesUser < ActiveRecord::Base
  attr_accessible :country_code, :user_id
  belongs_to :country, foreign_key:"country_code"
  belongs_to :user
  @@total_of_countries=0
  @@count
  def self.count_of_visited_countries(user)
    @@count=self.where(:user_id=>user.email).size
  end

  def self.count_of_unvisited_countries(user)
    total # получим сначала общие количество стран
    @@total_of_countries-@@count # результатом будет количество не посещённых стран
  end

  def self.visited?(user,country_code)
    bool=self.where("user_id= ? AND country_code=?",user.email,country_code)
    bool.size>0 ? true : false
  end

  private
    def self.total
      @@total_of_countries=Country.all.size
    end
end
