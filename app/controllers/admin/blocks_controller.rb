class Admin::BlocksController < Comfy::Admin::Cms::BaseController

  before_action :load_block, only: [:show, :edit, :update, :move_up, :move_down, :destroy]

  def show
  end

  def edit
  end

  def create
    @block = Block.new(block_params)
    @block.block_area = BlockArea.find(params[:block_area_id])

    if block_params[:parent_id]
      @parent = Block.find(block_params[:parent_id])
      @block.parent = @parent
    end

    @block.save!
  end

  def update
    @block.update!(block_params)
    render action: :show
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = 'Failed to update Block Area'
    render action: :edit
  end

  def move_up
    @parent = @block.parent
    @prior = @block.prior_position
    @block.update! position: { before: @prior } if @prior
  end

  def move_down
    @parent = @block.parent
    @subsequent = @block.subsequent_position
    @block.update! position: { after: @subsequent } if @subsequent
  end

  def destroy
    @block.destroy
  end

protected

  def build_block
    @block = @site.blocks.new(block_params)
  end

  def load_block
    @block = Block.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Block not found'
    redirect_to action: :index
  end

  def block_params
    params.fetch(:block, {}).permit!
  end
end
