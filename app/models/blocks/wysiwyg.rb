module Blocks
  class Wysiwyg < Block
    store :data, accessors: [:content], coder: JSON

    def self.can_be_root?
      true
    end
  end
end
