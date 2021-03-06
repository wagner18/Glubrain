module ImagesCellStylesheet

  def cell_size
    {w: 125, h: 125}
  end

  def images_cell(st)
    st.frame = cell_size
    st.background_color = color.random

    # Style overall view here
    st.clips_to_bounds = true
  end

  def image(st)
    st.frame = :full
    st.view.contentMode = UIViewContentModeScaleAspectFill
  end

end
