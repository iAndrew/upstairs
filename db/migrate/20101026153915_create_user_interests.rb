class CreateUserInterests < ActiveRecord::Migration
  def self.up
    create_table :user_interests do |t|
      t.string :interest

      t.timestamps
    end
  end

  def self.down
    drop_table :user_interests
  end
end
