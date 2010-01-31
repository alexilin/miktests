class Subject < ActiveRecord::Base
  belongs_to :teacher, :class_name => "User"
  has_many :tests, :dependent => :destroy
end
