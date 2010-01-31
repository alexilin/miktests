class Test < ActiveRecord::Base
  belongs_to :subject
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true      
end
