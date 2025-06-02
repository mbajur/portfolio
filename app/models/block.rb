class Block < ApplicationRecord
  AVAILABLE_TYPES = %w[Blocks::Row Blocks::Column Blocks::Gallery Blocks::Image Blocks::Wysiwyg].freeze

  belongs_to :block_area

  cms_acts_as_tree counter_cache: :children_count, order: :position
  positioned on: :parent

  def self.can_be_root?
    false
  end

  def to_partial_path(mode = :preview)
    "comfy/admin/cms/#{type.underscore}/#{mode}"
  end

  def accepted_child_types
    []
  end
end
