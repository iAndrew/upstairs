class CreateUserContacts < ActiveRecord::Migration
  def self.up
    create_table :user_contacts do |t|
      t.string :contact_type
      t.string :contact_value

      t.timestamps
    end
  end

  def self.down
    drop_table :user_contacts
  end
end
