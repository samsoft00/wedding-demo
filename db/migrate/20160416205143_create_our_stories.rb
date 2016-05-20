class CreateOurStories < ActiveRecord::Migration
  def change
    create_table :our_stories do |t|
      t.string :how_we_meet
      t.string :first_date
      t.string :proposal
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
