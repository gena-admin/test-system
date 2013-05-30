class AddChoiceTranslations < ActiveRecord::Migration
  def change
    change_table :choices do |t|
      t.rename :title, :title_uk
      t.string :title_ru
      t.string :title_en
    end
  end
end
