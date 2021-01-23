class CreateUserCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_courses do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true
      t.datetime :buy_time
      t.integer :rest_course_count

      t.timestamps
    end
  end
end
