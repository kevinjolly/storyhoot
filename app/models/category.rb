class Category < ActiveRecord::Base
  has_many :books
  def to_param
    "#{id}-#{name}".parameterize
  end
end
