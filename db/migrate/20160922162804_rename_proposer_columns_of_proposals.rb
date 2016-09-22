class RenameProposerColumnsOfProposals < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      dir.up do
        transaction do
          execute <<-SQL.squish
            UPDATE proposals
               SET proposer_name = ''
             WHERE proposer_name is null
          SQL
          execute <<-SQL.squish
            UPDATE proposals
               SET proposer_email = ''
             WHERE proposer_email is null
          SQL
          execute <<-SQL.squish
            UPDATE proposals
               SET proposer_phone = ''
             WHERE proposer_phone is null
          SQL
        end
      end
    end

    change_column_null :proposals, :proposer_name, false
    change_column_null :proposals, :proposer_email, false
    change_column_null :proposals, :proposer_phone, false
  end
end
