class CreateCmsableContents < ActiveRecord::Migration
  def change
    create_table :cmsable_contents do |t|
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
