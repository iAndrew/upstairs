class RenameUserContactFields < ActiveRecord::Migration
  def self.up
    change_table :user_contacts do |t|
      t.rename :contact_type, :category
      t.rename :contact_value, :value
    end
  end

  def self.down
    change_table :user_contacts do |t|
      t.rename :category, :contact_type
      t.rename :value, :contact_value
    end
  end
end
