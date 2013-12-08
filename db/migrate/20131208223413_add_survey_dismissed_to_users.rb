class AddSurveyDismissedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :survey_dismissed, :boolean, default: false
  end
end
