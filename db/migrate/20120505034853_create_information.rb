class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.integer :user_id
      t.integer :project_id
      t.text :message

      t.timestamps
    end
  end
end
