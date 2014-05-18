require 'spec_helper'

class RMagickUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Piet::CarrierWaveExtension
end

class MiniMagickUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Piet::CarrierWaveExtension
end

describe Piet do
  describe Piet::CarrierWaveExtension do
    describe ".optimize" do
      let(:path) { File.join('spec', 'assets', 'piet.jpg') }
      let(:image) { File.open(path) }

      def upload_file(uploader)
        uploader.store!(image)
        uploader.manipulate! do |img|
          img
        end
      end

      it "calls the uploader's `current_path` when MiniMagick is used" do
        uploader = MiniMagickUploader.new

        upload_file(uploader)

        expect(Piet).to receive(:optimize).with(uploader.current_path, {})

        uploader.optimize
      end

      it "calls the uploader's `current_path` when RMagick is used" do
        uploader = RMagickUploader.new

        upload_file(uploader)

        expect(Piet).to receive(:optimize).with(uploader.current_path, {})

        uploader.optimize
      end
    end
  end
end
