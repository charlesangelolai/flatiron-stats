class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.integer :cohort_id
      t.integer :survey_data_id

      t.timestamps
    end
  end
end
