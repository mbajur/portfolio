module Blocks
  class Column < Block
    store :data, accessors: [:span, :css_classes], coder: JSON

    def accepted_child_types
      [Blocks::Image, Blocks::Wysiwyg, Blocks::Row, Blocks::Gallery]
    end
  end
end
