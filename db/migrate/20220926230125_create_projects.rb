class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false, default: ''
      t.text :description
      t.boolean :is_public, default: false
      t.belongs_to :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
