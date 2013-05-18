class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :video_url
      t.integer :sec
      t.string :hint
      t.belongs_to :group

      t.timestamps
    end
    add_index :questions, :group_id
  end
end
