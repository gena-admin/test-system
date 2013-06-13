class CreateProtectionInitialPositions < ActiveRecord::Migration
  def change
    create_table :protection_initial_positions do |t|
      t.string :alignment
      t.integer :dx
      t.integer :dy
      t.boolean :is_highlighted
      t.belongs_to :protection_question
      t.string :color

      t.timestamps
    end
    add_index :protection_initial_positions, :protection_question_id
  end
end
