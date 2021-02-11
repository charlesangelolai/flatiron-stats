class CreateCohorts < ActiveRecord::Migration[6.1]
  def change
    create_table :cohorts do |t|
      t.string :name
      t.string :program
      t.string :pace
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
