class CreateInvolvements < ActiveRecord::Migration
  def self.up
    create_table :involvements do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :status
      t.integer :role_id
      t.date :start_date
      t.date :end_date
      t.string :added_by
      t.string :edited_by

      t.timestamps
    end
    
    add_index "involvements", ["user_id", "group_id", "role_id"], :name => "index_involvements_on_user_id", :unique => true
    add_index "involvements", ["group_id"], :name => "index_involvements_on_group_id"

  end

  def self.down
    drop_table :involvements
  end
end
