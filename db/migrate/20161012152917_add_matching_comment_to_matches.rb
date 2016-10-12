class AddMatchingCommentToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :matching_comment, :text
  end
end
