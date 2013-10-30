class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :slugify

  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  SPACE_REGEXP = /\s/
  SYMBOL_REGEXP = /[^\w-]/

  def slugify
    self.slug = self.title.downcase.strip.gsub(SPACE_REGEXP, "-").gsub(SYMBOL_REGEXP, "")
  end
end