class Category < ActiveRecord::Base
  validates :title, presence: true,
                    uniqueness: true

  has_many :projects

  before_save :to_slug

  def to_slug
    self.slug = title.parameterize
  end
end
