# frozen_string_literal: true

# Tag for text content that is going to be rendered using text input
#   {{ cms:block_area }}
#
class ComfortableMediaSurfer::Content::Tags::BlockArea < ComfortableMediaSurfer::Content::Tags::Fragment
  def render
    renderable ? Comfy::Cms::ContentController.render(partial: 'comfy/cms/block_areas/renderer', locals: { block_area: BlockArea.find(content) }) : ''
  end

  def form_field(object_name, view, index)
    name    = "#{object_name}[fragments_attributes][#{index}][content]"
    options = { id: form_field_id, class: 'form-control', include_blank: true }
    options_for_select = view.options_from_collection_for_select(BlockArea.all, :id, :identifier, content)
    input   = view.send(:select_tag, name, options_for_select, options)

    yield input
  end
end

ComfortableMediaSurfer::Content::Renderer.register_tag(
  :block_area, ComfortableMediaSurfer::Content::Tags::BlockArea
)
