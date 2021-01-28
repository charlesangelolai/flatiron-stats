class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.string :name
      t.integer :phase_num

      t.timestamps
    end
  end
end
