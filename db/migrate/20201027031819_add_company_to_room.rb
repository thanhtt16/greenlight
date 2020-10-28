class AddCompanyToRoom < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :company
  end
end
