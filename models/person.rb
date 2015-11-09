class Person < ActiveRecord::Base
  belongs_to :party, touch: true
  belongs_to :category
  default_scope { order('sort_order ASC') }
  scope :attending, -> { where(attending: true) }
end
