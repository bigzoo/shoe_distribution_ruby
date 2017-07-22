class Store < ActiveRecord::Base
  has_many :sales
  has_many :brands, through: :sales
end
