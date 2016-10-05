class MultipleCommittees < ActiveRecord::Migration[5.0]
  def up
    transaction do
      Project.with_deleted.each do |project|
        next unless project.try(:committee).try(:present?)
        query = "INSERT INTO assigned_committees(committee_id, project_id, created_at, updated_at) VALUES (#{project.committee_id}, #{project.id}, now(), now())"
        ActiveRecord::Base.connection.execute query
        say query
      end
      remove_column :projects, :committee_id
    end
  end

  def down
    raise "지원안함"
  end
end
