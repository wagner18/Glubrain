class ImagesCell < UICollectionViewCell
  attr_reader :reused

  def rmq_build
    rmq(self).apply_style :images_cell

    # Add your subviews, init stuff here
    # @foo = q.append!(UILabel, :foo)
    rmq(self.contentView).tap do |q|
      @image = q.append(UIImageView, :image).get
    end

  end

  def prepareForReuse
    @reused = true
  end

  def update(image_url)

    #obj_image = UIImage.imageWithContentsOfFile(NSURL.URLWithString(image_url))
    #@image.setImageWithURL(image_url && NSURL.URLWithString(image_url))
    @image.url = "https:#{image_url}"

  end


end
