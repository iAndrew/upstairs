class AddBaseInformationToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :nickname
      t.string :first_name
      t.string :second_name
      t.date :birth_date
      t.text :about_me
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :first_name, :second_name, :birth_date, :about_me
      t.string :nickname
    end
  end
end
