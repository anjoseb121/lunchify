class CreateScheduleLunches < ActiveRecord::Migration[6.1]
  def change
    create_table :schedule_lunches do |t|
      t.belongs_to :user
      t.belongs_to :lunch
      t.integer :week_of_year
      t.integer :year
      t.integer :day
      t.timestamps
    end
  end
end
