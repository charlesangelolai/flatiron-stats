class CreateCohorts < ActiveRecord::Migration[6.1]
  def change
    create_table :cohorts do |t|
      t.string :name
      t.string :program
      t.string :status

      t.timestamps
    end
  end
end
