class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.boolean :is_public, default: false
      t.integer :owner_id, index: true

      t.timestamps
    end

    add_foreign_key :projects, :users, column: :owner_id
  end
end
