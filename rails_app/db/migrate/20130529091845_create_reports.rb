class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :student_id
      t.integer :homework_id
      t.float :ratio
      t.float :quality
      t.float :time

      t.timestamps
    end
  end
end
