class AddQuestionTranslations < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.rename :title, :title_uk
      t.string :title_ru
      t.string :title_en
      t.rename :hint, :hint_uk
      t.string :hint_ru
      t.string :hint_en
    end
  end
end
