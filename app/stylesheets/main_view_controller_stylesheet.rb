class MainViewControllerStylesheet < ApplicationStylesheet
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
    st.background_image = image.resource('opacBackground_1242x2208.png')
    #st.view.frame
    #st.superview.center
  end

  def main_view(st)
     st.background_color = color.translucent_white
     st.opacity = 0.60
  end

  def from_button(st)
    st.frame = {l: 0, top: 64, w: @screen[:width] / 2 - 22, h: 40}
    st.content_vertical_alignment = UIControlContentVerticalAlignmentCenter
    st.background_color = color.default_blue#color.white
    st.color = color.white
    st.text = "From"
    st.font = font.small
    #st.return_key_type = true
    #st.z_position = 99
  end

  def swap_button(st)

    st.frame = {l: st.prev_frame.width, top: 64, w: 44, h: 40}
    st.content_vertical_alignment = UIControlContentVerticalAlignmentCenter
    st.background_color = color.default_blue#color.white
    st.image_normal = icon_image(:ion, :arrow_swap, size: 22, color: color.white)
    st.image_highlighted = icon_image(:ion, :arrow_swap, size: 22, color: color.black)
    #st.size_to_fit = true
    #st.font = font.small
    #st.return_key_type = true
    #st.z_position = 99
  end

  def to_button(st)
    st.frame = {l: @screen[:width] / 2 + 22, top: 64, w: @screen[:width] / 2 - 22, h: 40}
    st.content_vertical_alignment = UIControlContentVerticalAlignmentCenter
    st.background_color = color.default_blue#color.white
    st.color = color.white
    st.text = "To"
    st.font = font.small
    #st.return_key_type = true
    #st.z_position = 99
  end

  def source_field(st)
    st.frame = {left: 0, top: 105, w: @screen[:width], h: 90}
    st.corner_radius = 0
    st.z_position = 10
    #st.scroll_enabled = false
    # st.bounces = true
    st.text = "tap to enter text"
    st.color = color.gray
    st.font = font.standard
    st.return_key_type = false #UIReturnKeyDefault
    st.keyboard_type = UIKeyboardTypeDefault
    st.keyboard_appearance = UIKeyboardAppearanceDefault
    st.spell_checking_type = UITextSpellCheckingTypeYes
    st.autocapitalization_type = UITextAutocapitalizationTypeSentences
    st.content_size = CGSizeMake(@screen[:width], 70)
    # shadow(st)
  end

  def translate_button(st)
    st.frame = {l: @screen[:width] - 45, top: st.prev_frame.y + st.prev_frame.height - 17.5, w: 35, h: 35}
    st.z_position = 99
    st.corner_radius = 17.5
    #st.content_vertical_alignment = UIControlContentVerticalAlignmentCenter
    st.background_color = color.default_blue
    st.color = color.black
    st.image_normal = icon_image(:ion, :ios_arrow_thin_down, size: 35, color: color.white)
    st.image_highlighted = icon_image(:ion, :ios_arrow_thin_down, size: 32, color: color.black)
  end

  def result_field(st)
    st.frame = {left: 0, top: st.prev_frame.y + st.prev_frame.height - 17, w: @screen[:width], h: 130}
    st.z_position = 9
    st.font = font.standard
    st.background_color = color.white
    st.editable = false
    #st.border_style = UITextBorderStyleRoundedRect
    shadow(st)
  end

  def result_options(st)
    st.frame = {left: 0, top: st.prev_frame.y + st.prev_frame.height + 4, w: @screen[:width], h: 130}
    st.corner_radius = 8
    st.background_color = color.white
    st.editable = false
    #st.resize_height_to_fit = true
    # st.view.numberOfLines = 0
    # st.view.lineBreakMode = NSLineBreakByWordWrapping
    #st.border_style = UITextBorderStyleRoundedRect
  end

  def cam_button(st)
    st.frame = {left: 5, top: st.prev_frame.y + st.prev_frame.height + 5, w: @screen[:width] / 2 - 10, height: 30}
    st.background_color = color.l_blue
    st.color = color.black
    st.text = "Camera"

    st.clips_to_bounds = false
    st.view.layer.tap do |l|
      l.shadowColor = color.black.CGColor
      l.shadowOpacity = 0.2
      l.shadowRadius = 1.5
      l.shadowOffset = [0.5, 1.5]
    end
  end

  def mic_button(st)
    st.frame = {left: @screen[:width] / 2 + 5, top: st.prev_frame.y, w: @screen[:width] / 2 - 10, height: 30}
    st.background_color = color.l_blue
    st.color = color.black
    st.text = "Microphone"
  end
  
  def scadule_button(st)
    st.frame = {left: 5, top: @screen[:height] - 84, w: @screen[:width] - 10, height: 30}
    st.background_color = color.l_blue
    st.color = color.black
    st.text = "Scadule"
  end

end
