class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :tier
      t.string :rank
      t.string :image
      t.string :lol_id
      t.string :verification_key
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
