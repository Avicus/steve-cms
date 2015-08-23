class CreateUsernames < ActiveRecord::Migration
  def change
    create_table :usernames do |t|
      t.references :user, index: true
      t.string :name
      t.datetime :created_at
    end
  end
end
