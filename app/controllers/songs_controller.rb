class SongsController < ApplicationController
  def index
    @songs = AWS::S3::Bucket.find(ENV["AWS_BUCKET_NAME"]).objects
  end

  def upload
    begin
      AWS::S3::S3Object.store(sanitize_filename(params[:mp3file].original_filename), params[:mp3file].read, ENV["AWS_BUCKET_NAME"], :access => :public_read)
      redirect_to root_path
    rescue
      render :text => "Couldn't complete the upload"
    end
  end

  def delete
    if (params[:song])
      AWS::S3::S3Object.find(params[:song], ENV["AWS_BUCKET_NAME"]).delete
      redirect_to root_path
    else
      render :text => "No song was found to delete!"
    end
  end

  private

  def sanitize_filename(file_name)
    just_filename = File.basename(file_name)
    just_filename.sub(/[^\w\.\-]/,'_')
  end
end
