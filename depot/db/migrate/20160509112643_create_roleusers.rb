class CreateRoleusers < ActiveRecord::Migration
  def change
    create_table :roleusers do |t|
     t.references :role
      t.references :user
      
      t.timestamps
    end
  end
end
