class Brand < ActiveRecord::Base
  has_many :sales
  has_many :stores, through: :sales
end
