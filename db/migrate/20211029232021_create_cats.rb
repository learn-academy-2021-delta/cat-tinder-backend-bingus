class CreateCats < ActiveRecord::Migration[6.1]
  def change
    create_table :cats do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :breed
      t.text :enjoys

      t.timestamps
    end
  end
end
