class CreateProtectionQuizzes < ActiveRecord::Migration
  def change
    create_table :protection_quizzes do |t|
      t.belongs_to :user
      t.datetime :finished_at

      t.timestamps
    end
    add_index :protection_quizzes, :user_id
  end
end
