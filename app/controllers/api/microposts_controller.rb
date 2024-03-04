class Api::MicropostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_micropost, only: [:show, :update, :destroy]

  def index
    @microposts = current_user.microposts
    render json: @microposts
  end

  def show
    render json: @micropost
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      render json: {
          status: { code: 200, message: 'Create microposts successfully',
                    data: @micropost   }
         }, status: :ok
    else
      render json: @micropost.errors, status: :unprocessable_entity
    end
  end

  def update
    if @micropost.update(micropost_params)
      render json: {
          status: { code: 200, message: 'Update microposts successfully',
                    data: @micropost   }
         }, status: :ok
    else
      render json: @micropost.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @micropost
      render json: {
        status: { code: 200, message: 'Delete microposts successfully',
                  data: @micropost }
                }
      @micropost.destroy
    end


  end

  private

  def set_micropost
    @micropost = current_user.microposts.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
