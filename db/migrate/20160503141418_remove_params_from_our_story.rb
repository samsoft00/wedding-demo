class RemoveParamsFromOurStory < ActiveRecord::Migration
  def change
    remove_column :our_stories, :how_we_meet, :string
    remove_column :our_stories, :first_date, :string
    remove_column :our_stories, :proposal, :string
  end
end
