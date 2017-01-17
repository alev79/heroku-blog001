class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body
      #t.boolean :public_flag
      t.integer :public_flag,:default=>"0",:null=>false
      t.integer :point

      t.timestamps
    end
  end
end
