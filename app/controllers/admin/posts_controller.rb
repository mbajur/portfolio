class Admin::PostsController < Alchemy::Admin::ResourcesController
  private

  def resource_params
    params.require(:post).permit(:image)
  end
end
