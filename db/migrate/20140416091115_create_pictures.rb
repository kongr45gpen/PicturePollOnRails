class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :filename
      t.references :author, index: true

      t.timestamps
    end
  end
end
