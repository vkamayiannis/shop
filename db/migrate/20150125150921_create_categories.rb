class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :descr

      t.timestamps
    end
  end
end
