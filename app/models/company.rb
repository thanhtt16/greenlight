class Company < ApplicationRecord
  after_create :setup_company
  has_many :users, dependent: :destroy
  def self.admins_search(string)
    return all if string.blank?
    search_query = "LOWER( companies.name ) LIKE :search"

    search_param = "%#{sanitize_sql_like(string)}%"
    where(search_query, search: search_param)
  end

  def self.admins_order(column, direction)
    # Arel.sql to avoid sql injection
    order(Arel.sql("companies.#{column} #{direction}"))
  end

  private

  def setup_company
    # Initializes a room for the user and assign a BigBlueButton user id.
    id = "gl-#{(0...12).map { rand(65..90).chr }.join.downcase}"

    update(uid: id)
    save
  end
end
