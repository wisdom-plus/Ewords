class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :word, null: false,limit: 255
      t.text :reading,null: false
      t.integer :level, null: false, default: 0
      t.integer :kind, null: false, default: 0
      t.timestamps
    end
  end
end
