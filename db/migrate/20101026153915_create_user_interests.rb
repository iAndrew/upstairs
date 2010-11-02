class CreateUserInterests < ActiveRecord::Migration
  def self.up
    create_table :user_interests do |t|
      t.string :interest
      t.integer :user_id
      
      t.timestamps
    end
    add_index :user_interests, :user_id
  end

  def self.down
    remove_index :user_interests, :column => :user_id 
    drop_table :user_interests
  end
end
