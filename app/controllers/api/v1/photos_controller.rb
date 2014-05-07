class Api::V1::PhotosController < Api::V1::BaseController
  before_action :fetch_photos, only: [:index]
  before_action :fetch_photo, except: [:index, :create]
  before_action :process_attached_file, only: [:create]

  def index
    render json: @photos
  end

  def show
    render json: @photo
  end

  def create
    photo = Photo.new photo_create_params

    if photo.save
      head :created, location: api_v1_photo_url(photo)
    else
      head :unprocessable_entity
    end
  end

  def destroy
    if @photo.destroy
      head :no_content
    else
      head :conflict
    end
  end

  def update
    if @photo.update photo_update_params
      head :no_content, location: api_v1_photo_url(@photo)
    else
      head :unprocessable_entity
    end
  end

  private
    def fetch_photos
      @photos = Photo.all
    end

    def fetch_photo
      @photo = Photo.find params[:id]
    end

    def photo_create_params
      params.require(:photo).permit(:name, :description, :media)
    end

    def photo_update_params
      params.require(:photo).permit(:name, :description)
    end

    def process_attached_file
      if params[:photo][:media]['data']
        photo_params = params[:photo][:media]

        tempfile = Tempfile.new('photo_upload')
        tempfile.binmode
        tempfile.write Base64.decode64(photo_params['data'])

        uploaded_file = ActionDispatch::Http::UploadedFile.new(
          tempfile:           tempfile,
          filename:           photo_params['filename'],
          original_filename:  photo_params['original_filename']
        )
        uploaded_file.content_type = photo_params['content_type']
        params[:photo][:media] = uploaded_file

        tempfile.delete
      end
    end
end
