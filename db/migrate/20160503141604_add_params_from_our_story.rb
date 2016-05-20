class AddParamsFromOurStory < ActiveRecord::Migration
  def change
    add_column :our_stories, :how_we_meet, :text
    add_column :our_stories, :first_date, :text
    add_column :our_stories, :proposal, :text
  end
end
