class Entry < ActiveRecord::Base
  attr_accessible :body, :point, :public_flag, :title
  belongs_to :blogger
  scope :latest,order('updated_at desc')
end
