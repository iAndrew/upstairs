class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.string :type
      t.string :citation
      t.string :citation_author
      t.string :aim_of_project
      t.string :client
      t.string :web_page

      t.timestamps
    end
    add_index :groups, :name, :unique => true
  end



  def self.down
    drop_table :groups
  end
end
