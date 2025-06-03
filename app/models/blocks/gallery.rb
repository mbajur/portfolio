module Blocks
  class Gallery < Block
    store :data, accessors: [:columns, :css_classes], coder: JSON

    def self.can_be_root?
      false
    end

    def accepted_child_types
      [Blocks::Image]
    end
  end
end
