class CreateUserCourseDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_course_details do |t|
      t.belongs_to :user_course, null: false, foreign_key: true
      t.text :check_time, array: true, default: []

      t.timestamps
    end
  end
end
