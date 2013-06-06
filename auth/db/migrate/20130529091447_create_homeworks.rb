class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :title
      t.string :language
      t.text :description

      t.timestamps
    end
  end
end
