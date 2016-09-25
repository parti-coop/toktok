class AddParticipationsGoalCountAtProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :participations_goal_count, :integer, default: 1000
  end
end
