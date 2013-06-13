class CreateProtectionAnsweredPositions < ActiveRecord::Migration
  def change
    create_table :protection_answered_positions do |t|
      t.string :alignment
      t.integer :dx
      t.integer :dy
      t.boolean :is_highlighted
      t.belongs_to :protection_answer
      t.string :color

      t.timestamps
    end
    add_index :protection_answered_positions, :protection_answer_id
  end
end
