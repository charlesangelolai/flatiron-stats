class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :phase_num
      t.text :description
      t.string :website_link
      t.string :github_link
      t.string :blog_link
      t.string :video_link
      t.integer :user_id

      t.timestamps
    end
  end
end
