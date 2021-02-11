class CreateSurveyQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_questions do |t|
      t.string :design_question
      t.string :navigation_question
      t.string :error_handling_question
      t.integer :survey_id

      t.timestamps
    end
  end
end
