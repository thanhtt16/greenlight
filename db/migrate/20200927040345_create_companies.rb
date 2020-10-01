# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :uid
      t.string :image

      t.timestamps
    end
  end
end
