class CreateCountriesUsers < ActiveRecord::Migration
  def change
    create_table :countries_users do |t|
      t.string :user_id, :null=>false
      t.string :country_code, :null=>false

      t.timestamps
    end
  end
end
