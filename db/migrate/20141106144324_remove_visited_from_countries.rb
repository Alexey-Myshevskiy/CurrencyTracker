class RemoveVisitedFromCountries < ActiveRecord::Migration
  def up
    remove_column :countries, :visited
  end

  def down
    add_column :countries, :visited, :string
  end
end
