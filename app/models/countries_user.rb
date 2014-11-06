class CountriesUser < ActiveRecord::Base
  attr_accessible :country_code, :user_id
  belongs_to :country, foreign_key:"country_code"
  belongs_to :user
end
