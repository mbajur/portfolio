module Comfy
  module Cms
    module SiteDecorator
      def self.prepended(base)
        base.has_many :block_areas, class_name: 'BlockArea', dependent: :destroy
      end
    end
  end
end

Comfy::Cms::Site.prepend Comfy::Cms::SiteDecorator
