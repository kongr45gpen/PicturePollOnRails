class PicturesController < ApplicationController
    def new
        @picture = Picture.new
    end

    def create
        @picture = Picture.create(picture_params)
        redirect_to picture_path(@picture)
    end

    def show
        @picture = Picture.find(params[:id])
    end

    def edit
        @picture = Picture.find(params[:id])
    end

    def update
        @picture = Picture.find(params[:id])

        if @picture.update(picture_params)
            redirect_to @picture
        else
            render 'edit'
        end
    end

    def index
        if params[:author_id]
            @author = Author.find(params[:author_id])
            @pictures = @author.pictures
        else
            @pictures = Picture.all
        end
    end

    def destroy
        @picture = Picture.find(params[:id])
        @picture.destroy

        redirect_to pictures_path
    end

    private
        def picture_params
            params.require(:picture).permit(:name, :filename, :author_id)
        end
end
