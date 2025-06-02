module Blocks
  class Image < Block
    has_one_attached :file

    def self.can_be_root?
      true
    end
  end
end
