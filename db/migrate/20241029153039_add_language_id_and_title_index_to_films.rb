class AddLanguageIdAndTitleIndexToFilms < ActiveRecord::Migration[7.1]
  def change
    add_index :films, [:language_id, :title]
  end
end
