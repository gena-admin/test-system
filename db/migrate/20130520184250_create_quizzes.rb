class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.belongs_to :user
      t.datetime :finished_at

      t.timestamps
    end
    add_index :quizzes, :user_id
  end
end
