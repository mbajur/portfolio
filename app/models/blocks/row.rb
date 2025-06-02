module Blocks
  class Row < Block
    store :data, accessors: [:columns], coder: JSON

    def accepted_child_types
      [Blocks::Column]
    end

    def self.can_be_root?
      false
    end
  end
end
