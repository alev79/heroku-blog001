class AddColumnEntry < ActiveRecord::Migration
  def up
      add_column :entries,:blogger_id,:integer,:default=>"0",:null=>false
      add_index :entries,[:blogger_id,:updated_at]
  end

  def down
      drop_index :entries,[:blogger_id,:updated_at]
  end
end
