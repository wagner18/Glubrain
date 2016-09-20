class HomescreenControllerStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def table(st)
    st.background_color = color.gray
  end

  def homeScreen_cell_height
    80
  end

  def homeScreen_cell(st)
    # Style overall cell here
    st.background_color = color.very_light_gray
  end

  def cell_label(st)
    st.color = color.black
  end
end
