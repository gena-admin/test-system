class CreateProtectionAnswers < ActiveRecord::Migration
  def change
    create_table :protection_answers do |t|
      t.belongs_to :protection_question
      t.belongs_to :protection_quiz
      t.datetime :started_at
      t.datetime :answered_at

      t.timestamps
    end
    add_index :protection_answers, :protection_question_id
    add_index :protection_answers, :protection_quiz_id
  end
end
