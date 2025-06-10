require "dragonfly/s3_data_store"

# AlchemyCMS Dragonfly configuration.
#
# Consider using some kind of caching solution for image processing.
# For small projects, we have good experience with Rack::Cache.
#
# Larger installations should consider using a CDN, start reading
# http://markevans.github.io/dragonfly/cache/
#
# A complete reference can be found at
# http://markevans.github.io/dragonfly/configuration
#
# Pictures
#
Dragonfly.app(:alchemy_pictures).configure do
  dragonfly_url nil
  plugin :imagemagick
  secret "13847e0f2da650a27377e0bcf5b6bb6a2b335c8555645331f204d227692e9704"
  url_format "/pictures/:job/:basename.:ext"

  if Rails.env.production?
    datastore :s3, Rails.application.credentials.aws
  else
    datastore :file,
      root_path: Rails.root.join("uploads/pictures").to_s,
      server_root: Rails.root.join("public"),
      store_meta: false
  end
end

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware, :alchemy_pictures

# Attachments
Dragonfly.app(:alchemy_attachments).configure do
  if Rails.env.production?
    datastore :s3, Rails.application.credentials.aws
  else
    datastore :file,
      root_path: Rails.root.join("uploads/attachments").to_s,
      store_meta: false
  end
end
