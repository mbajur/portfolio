class BlockArea < ActiveRecord::Base

  # -- Relationships -----------------------------------------------------------
  belongs_to :site, class_name: 'Comfy::Cms::Site'
  has_many :blocks, dependent: :destroy

  accepts_nested_attributes_for :blocks, allow_destroy: true

  # -- Callbacks ---------------------------------------------------------------

  # -- Validations -------------------------------------------------------------
  validates :site_id,
    presence: true
  validates :label,
    presence: true

  # -- Scopes ------------------------------------------------------------------


  # -- Class Methods -----------------------------------------------------------


  # -- Instance Methods --------------------------------------------------------
end
