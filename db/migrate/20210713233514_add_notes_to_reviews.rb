class AddNotesToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :notes, :string
  end
end
