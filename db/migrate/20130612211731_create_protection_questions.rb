class CreateProtectionQuestions < ActiveRecord::Migration
  def change
    create_table :protection_questions do |t|
      t.string :video_url
      t.integer :sec
      t.string :title_ru
      t.string :title_en
      t.string :title_uk
      t.string :hint_ru
      t.string :hint_en
      t.string :hint_uk

      t.timestamps
    end
  end
end
