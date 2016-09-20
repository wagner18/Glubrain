class MainViewStylesheet < ApplicationStylesheet
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
    st.background_color = color.white
    st.background_image = image.resource('soft_blue736X1308.jpg')
    
    st.background_color = color.translucent_white
    st.opacity = 0.70
  end


end
