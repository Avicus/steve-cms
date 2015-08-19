class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.references :user, index: true
      t.references :group, index: true
      t.boolean :active
      t.datetime :expires_at

      t.timestamps
    end
  end
end
