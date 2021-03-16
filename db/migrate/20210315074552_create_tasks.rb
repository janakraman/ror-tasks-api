class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.date :due_date
      t.string :priority
      t.boolean :completed, :default => false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
