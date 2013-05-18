class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :alignment
      t.integer :dx
      t.integer :dy
      t.boolean :is_highlighted
      t.belongs_to :question
      t.string :color

      t.timestamps
    end
    add_index :positions, :question_id
  end
end
