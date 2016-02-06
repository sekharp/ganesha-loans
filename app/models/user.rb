class User < ActiveRecord::Base
  has_secure_password

  has_many :loans
  has_many :projects
  has_many :user_roles
  has_many :roles, through: :user_roles

  has_attached_file :image,
                    styles: {
                      thumb: '100x100>',
                      square: '200x200#',
                      medium: '300x300>'
                    },
                    default_url: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  validates :username, presence: true,
                       uniqueness: true
  validates :password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :slug, presence: true

  before_validation :set_slug

  # enum role: %w(default admin)

  def set_slug
    self.slug = full_name.parameterize
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    roles.exists?(name: "admin")
  end

  def borrower?
    roles.exists?(name: "borrower")
  end

  def lender?
    roles.exists?(name: "lender")
  end
end
