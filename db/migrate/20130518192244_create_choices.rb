class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :title
      t.belongs_to :question
      t.boolean :is_correct

      t.timestamps
    end
    add_index :choices, :question_id
  end
end
