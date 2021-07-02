class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :appointment_type
      t.date :date
      t.time :time
      t.text :notes
      t.belongs_to :doctor, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
