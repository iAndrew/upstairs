class CreateUserContacts < ActiveRecord::Migration
  def self.up
    create_table :user_contacts do |t|
      t.string :contact_type
      t.string :contact_value
      t.integer :user_id

      t.timestamps
    end
    add_index :user_contacts, :user_id
  end

  def self.down
    remove_index :user_contacts, :column => :user_id 
    drop_table :user_contacts
  end
end
