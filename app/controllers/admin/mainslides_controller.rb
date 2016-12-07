module Admin
  class MainslidesController < BaseController
    load_and_authorize_resource

    def index
      @mainslides = Mainslide.all
    end

    def new
      @mainslide = Mainslide.new
    end

    def create
      @mainslide = Mainslide.new(mainslide_params)
      if @mainslide.save
        redirect_to admin_mainslides_path
      else
        errors_to_flash(@mainslide)
        render 'new'
      end
    end

    def update
      if @mainslide.update(mainslide_params)
        redirect_to admin_mainslides_path
      else
        errors_to_flash(@mainslide)
        render 'edit'
      end
    end

    def destroy
      errors_to_flash(@mainslide) unless @mainslide.destroy
      redirect_to admin_mainslides_path
    end

    private

    def mainslide_params
      params.require(:mainslide).permit(:order, :url, :image)
    end
  end
end
