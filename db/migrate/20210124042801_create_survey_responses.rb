class CreateSurveyResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_responses do |t|
      t.integer :design_response
      t.integer :navigation_response
      t.integer :error_handling_response
      t.integer :survey_id
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
