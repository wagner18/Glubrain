class MainStylesheet < ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
    #st.background_image = image.resource('bg_login.jpg')
  end

  def background_sheet(st)
    st.frame = {width: st.superview.frame.size.width, height: 500}
    st.background_color = color.translucent_black
  end

end
