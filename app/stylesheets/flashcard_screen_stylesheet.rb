class FlashcardScreenStylesheet < ApplicationStylesheet

  # Add your view stylesheets here. You can then override styles if needed, example:
  # include FooStylesheet


  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
    @screen = {
      :width => rmq.device.width,
      :height => rmq.device.height
    }
    @layout = LayoutView.new
    @padding = 2
  end

  def root_view(st)
    st.background_color = color.very_light_gray
    st.background_image = image.resource('opacBackground_1242x2208.png')
    #st.view.frame
    #st.superview.center
    # st.opacity = 0.60
  end

  def form_view(st)
    st.background_color = color.translucent_white
  end

  def subjects(st)
    st.background_color = color.black#translucent_white 
  end


end