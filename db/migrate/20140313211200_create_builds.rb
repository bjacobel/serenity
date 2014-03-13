class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :status
      t.boolean :passed
      t.text :output

      t.timestamps
    end
  end
end
