class Admin::BlockAreasController < Comfy::Admin::Cms::BaseController

  before_action :build_block_area,  only: [:new, :create]
  before_action :load_block_area,   only: [:show, :edit, :update, :destroy]

  def index
    @block_areas = BlockArea.page(params[:page])
  end

  def show
    render
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @block_area.save!
    flash[:success] = 'Block Area created'
    redirect_to admin_comfy_cms_site_block_area_path(@site, @block_area)
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to create Block Area'
    render action: :new
  end

  def update
    @block_area.update!(block_area_params)
    flash[:success] = 'Block Area updated'
    redirect_to action: :show, id: @block_area
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to update Block Area'
    render action: :edit
  end

  def destroy
    @block_area.destroy
    flash[:success] = 'Block Area deleted'
    redirect_to action: :index
  end

protected

  def build_block_area
    @block_area = @site.block_areas.new(block_area_params)
  end

  def load_block_area
    @block_area = BlockArea.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Block Area not found'
    redirect_to action: :index
  end

  def block_area_params
    params.fetch(:block_area, {}).permit(:label, :site_id, :identifier)
  end
end
