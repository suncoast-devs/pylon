class DropUnusedTables < ActiveRecord::Migration[6.0]
  def change
    execute "drop view IF EXISTS hdb_views.user__insert__public__note"
    execute %{drop view IF EXISTS hdb_views."user__insert__public__assignmentNote"}
    execute %{drop view IF EXISTS hdb_views.user__insert__public__link}
    execute %{drop view IF EXISTS hdb_views.user__insert__public__email}
    execute %{drop view IF EXISTS hdb_views.user__insert__public__address}

    drop_table :assignmentNote, if_exists: true
    drop_table :personNote, if_exists: true
    drop_table :note, if_exists: true
    drop_table :link, if_exists: true
    drop_table :email, if_exists: true

    drop_table :address, if_exists: true
    drop_table :assignment, if_exists: true
    drop_table :attendanceRecord, if_exists: true
    drop_table :homework, if_exists: true
    drop_table :links, if_exists: true
    drop_table :notes, if_exists: true
    drop_table :phone_numbers, if_exists: true
    drop_table :student_profiles, if_exists: true
    drop_table :studentProfile, if_exists: true
  end
end
