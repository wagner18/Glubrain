class ImagesView < UIView

  attr_accessor :images_urls

  IMAGES_CELL_ID = "ImagesCell"

  def initWithFrame(frame)

    if super


      layout = UICollectionViewFlowLayout.alloc.init
      @collection_view = UICollectionView.alloc.initWithFrame(self.bounds, collectionViewLayout: layout)

      @collection_view.registerClass(ImagesCell, forCellWithReuseIdentifier: IMAGES_CELL_ID)
      @collection_view.delegate = self
      @collection_view.dataSource = self
      @collection_view.allowsSelection = true
      @collection_view.allowsMultipleSelection = false

      self.addSubview(@collection_view)

      rmq.stylesheet = ImagesControllerStylesheet
      rmq(@collection_view).apply_style :collection_view

    end

    self

  end

  def numberOfSectionsInCollectionView(view)
    1
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  # def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
  #   rmq(:reapply_style).reapply_styles
  # end

  def collectionView(view, numberOfItemsInSection: section)
    @images_urls.length
  end

  def collectionView(view, cellForItemAtIndexPath: index_path)
    view.dequeueReusableCellWithReuseIdentifier(IMAGES_CELL_ID, forIndexPath: index_path).tap do |cell|
      rmq.build(cell) unless cell.reused

      # Update cell's data here
      cell.update(@images_urls[index_path.row])
    end
  end

  def collectionView(view, didSelectItemAtIndexPath: index_path)
    cell = view.cellForItemAtIndexPath(index_path)
    image_zoom(@images_urls[index_path.row])
    
    puts "Selected at section: #{index_path.section}, row: #{index_path.row}"
  end


  def image_zoom(image)
    rmq.wrap(rmq.app.window).tap do |zoom|
      zoom.append(UIView, :overlay).animations.fade_in.on(:tap) do |sender|
        zoom.find(sender, :overlay_img, :overlay_note).hide.remove
      end

      puts image

      zoom.append(UIImageView, :overlay_img).get.url = "https:#{image}"
      zoom.append(UILabel, :overlay_note)
    end
  end

end
