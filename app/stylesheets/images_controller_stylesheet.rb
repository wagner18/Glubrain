class ImagesControllerStylesheet < ApplicationStylesheet

  include ImagesCellStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb

    @margin = ipad? ? 12 : 8
  end

  def collection_view(st)
    st.view.contentInset = [0, 0, 0, 0]
    st.background_color = color.white
    st.opacity = 1.0

    st.view.collectionViewLayout.tap do |cl|
      cl.itemSize = [cell_size[:w], cell_size[:h]]
      #cl.scrollDirection = UICollectionViewScrollDirectionHorizontal
      #cl.headerReferenceSize = [cell_size[:w], cell_size[:h]]
      cl.minimumInteritemSpacing = 0
      cl.minimumLineSpacing = 0
      #cl.sectionInset = [0,0,0,0]
    end
  end


  def overlay(st)
    st.frame = :full
    st.background_color = color.from_rgba(0,0,0,0.6)
  end

  def overlay_img(st)
    st.frame = :full
    st.view.contentMode = UIViewContentModeScaleAspectFit
  end

  def overlay_note(st)
    st.frame = {t: 90, w: 300, h: 20}
    st.text = "tap over to close"
    st.font = font.small
    st.color = color.white
    st.text_alignment = :center
  end

end
