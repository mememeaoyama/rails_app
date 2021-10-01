class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :body
      t.string :perform
      t.integer :level_popular
      t.integer :level_difficult

      t.timestamps
    end
  end
end
