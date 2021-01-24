class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :user_type, default: "student"
      t.integer :cohort_id
      t.integer :survey_response_id

      t.timestamps
    end
  end
end
