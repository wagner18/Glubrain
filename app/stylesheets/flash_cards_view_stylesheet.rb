class FlashCardsViewStylesheet < ApplicationStylesheet
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
    #st.background_image = image.resource('opacBackground_1242x2208.png')
    #st.view.frame
    #st.superview.center
  end

  def view_container(st)
    st.frame = {l: 0, t: 0, w: @screen[:width], h: @screen[:height]}
    st.bounces = true
    st.content_size = CGSizeMake(@screen[:width], @screen[:height])
    st.z_position = 0
  end

  def subject_button(st)
    standard_form(st)

    st.frame = {left: 0, top: 5, w: @screen[:width], h: 60}
    st.text = "tap to chose a subject"
    st.corner_radius = 0
    st.color = color.black
    st.background_color = color.white
    st.font = font.large
    shadow(st)
  end

  def term_field(st)
    standard_form(st)

    st.frame = {left: 0, top: st.prev_frame.y + st.prev_frame.height + 10, w: @screen[:width], h: 60}
    st.placeholder = "Title/Term"
    st.corner_radius = 0
    st.background_color = color.white
    st.font = font.large
    # st.return_key_type = false #UIReturnKeyDefault
    # st.keyboard_type = UIKeyboardTypeDefault
    # st.keyboard_appearance = UIKeyboardAppearanceDefault
    # st.spell_checking_type = UITextSpellCheckingTypeYes
    # st.autocapitalization_type = UITextAutocapitalizationTypeSentences
    shadow(st)

  end


  def body_field(st)
    standard_form(st)

    st.frame = {left: 0, top: st.prev_frame.y + st.prev_frame.height + 10, w: @screen[:width] - 95, h: 95}
    st.corner_radius = 4
    st.font = font.standard
    st.background_color = color.white

    #st.border_style = UITextBorderStyleRoundedRect
    shadow(st)
  end

  def image_button(st)
    st.frame = {l: st.prev_frame.width + 0, top: st.prev_frame.y, w: 95, h: st.prev_frame.height}
    st.corner_radius = 4
    #st.content_vertical_alignment = UIControlContentVerticalAlignmentCenter
    st.background_color = color.white
    st.color = color.black
    st.image_normal = icon_image(:ion, :image, size: 45, color: color.light_gray)
    st.image_highlighted = icon_image(:ion, :image, size: 45, color: color.gray)

    shadow(st)
  end


  def image_conteiner(st)
    standard_form(st)
    shadow(st)

    st.frame = {left: 0, top: st.prev_frame.y + st.prev_frame.height + 10, w: @screen[:width], h: 220}
    st.background_color = color.white
    #st.content_size = CGSizeMake(@screen[:width], 1160);
  end


  def mic_button(st)
    standard_form(st)
    shadow(st)

    st.frame = {left: st.prev_frame.x + st.prev_frame.width + 10, top: st.prev_frame.y, w: @screen[:width] / 3 - 10, height: 30}
    st.background_color = color.default_blue
    st.color = color.white
    st.text = "Microphone"
    st.font = font.small
  end
  
  def scadule_button(st)
    standard_form(st)
    shadow(st)

    st.frame = {left: st.prev_frame.x + st.prev_frame.width + 10, top: st.prev_frame.y, w: @screen[:width] / 3 - 20, height: 30}
    st.background_color = color.default_blue
    st.color = color.white
    st.text = "Scadule"
    st.font = font.small
  end

end
