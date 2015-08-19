class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :display_name
      t.string :uuid
      t.string :locale
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
