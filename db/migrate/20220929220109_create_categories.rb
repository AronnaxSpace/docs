class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.belongs_to :project, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :parent, foreign_key: { to_table: :categories }

      t.timestamps
    end
  end
end
