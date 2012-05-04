class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :email
      t.string :title
      t.text :description
      t.string :url
      t.string :image
      t.integer :supporter_count

      t.timestamps
    end
  end
end
