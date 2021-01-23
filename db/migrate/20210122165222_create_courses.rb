class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name,  null: false
      t.string :description
      t.float :price, null: false
      t.boolean :status, default: true
      t.string :coach
      t.integer :course_count
      t.integer :expiry
      t.integer :member_limit

      t.timestamps
    end
  end
end
