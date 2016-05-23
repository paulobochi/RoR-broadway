class AddTrailerUrlToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :trailer_url, :string
  end
end
