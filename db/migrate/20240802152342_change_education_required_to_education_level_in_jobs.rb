class ChangeEducationRequiredToEducationLevelInJobs < ActiveRecord::Migration[7.1]
  def change
    rename_column :jobs, :education_required, :education_level
    change_column :jobs, :education_level, :enum, enum_type: :education_levels
  end
end
