class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :slug_it


  validates_presence_of :title, :content



  private

  def titleize_title
    self.title = title.titleize
  end

def slug_it
    lowercase_title = self.title.downcase
    lowercase_title.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'
    lowercase_title.gsub! /\A[-\.]+|[-\.]+\z/, ""

    self.slug = lowercase_title
  end

end