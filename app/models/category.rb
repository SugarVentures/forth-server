class Category < ActiveRecord::Base
  has_ancestry

  has_many :streams

  before_save :cache_ancestry
  def cache_ancestry
    path_names = path.map(&:name)
    path_names << name unless persisted?
    self.names_depth_cache = path_names.join('/')
  end
end
