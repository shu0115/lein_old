class CreateSupporters < ActiveRecord::Migration
  def change
    create_table :supporters do |t|
      t.integer :user_id
      t.integer :project_id
      t.boolean :payment, default: false
      t.string :profile_id

      t.timestamps
    end
  end
end
