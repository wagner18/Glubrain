class FlashCardsControllerStylesheet <  ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.random
    #st.background_image = image.resource('bg_login.jpg')
  end

end