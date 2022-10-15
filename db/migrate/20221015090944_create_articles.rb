class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.belongs_to :user, foreign_key: true
      t.belongs_to :project, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
