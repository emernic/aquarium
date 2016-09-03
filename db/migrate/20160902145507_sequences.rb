class Sequences < ActiveRecord::Migration

  def change

    create_table :sequences do |t|
      t.boolean :circular
      t.boolean :single_stranded
      t.timestamps
    end    

    create_table :sequence_versions do |t|
      t.integer :sequence_id 
      t.integer :parent_id
      t.text :data
      t.timestamps
    end

    create_table :features do |t|
      t.integer :super_id
      t.integer :sub_id
      t.string :name
      t.string :category
    end

  end

end
