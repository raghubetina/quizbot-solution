class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :role
      t.integer :quiz_id

      t.timestamps
    end
  end
end
