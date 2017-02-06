class Entry < ActiveRecord::Base
  #attr_accessor :body, :point, :public_flag, :title, :image
  belongs_to :blogger
  has_many :comments
  scope :latest,->{order('updated_at desc')}
  scope :public_entries,->{where('public_flag=true')}
  has_attached_file :image,styles:{small: "64x64",med: "100x100",large: "200x200"}
  validates_attachment :image, content_type: {content_type:["image/jpeg","image/gif","image/png"]}
end
