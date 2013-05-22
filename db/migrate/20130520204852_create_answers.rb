class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :question
      t.belongs_to :choice
      t.belongs_to :quiz
      t.datetime :started_at
      t.datetime :answered_at

      t.timestamps
    end
    add_index :answers, :question_id
    add_index :answers, :choice_id
    add_index :answers, :quiz_id
  end
end
