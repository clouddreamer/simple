class CreateSearchForms < ActiveRecord::Migration
  def change
    create_table :search_forms do |t|

      t.timestamps
    end
  end
end
