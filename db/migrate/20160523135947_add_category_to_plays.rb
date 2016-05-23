class AddCategoryToPlays < ActiveRecord::Migration
  def change
    add_reference :plays, :category, index: true, foreign_key: true
  end
end
