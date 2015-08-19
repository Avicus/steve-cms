class CreateGroupPermissions < ActiveRecord::Migration
  def change
    create_table :group_permissions do |t|
      t.references :group, index: true
      t.string :node
      t.boolean :negative

      t.timestamps
    end
  end
end
