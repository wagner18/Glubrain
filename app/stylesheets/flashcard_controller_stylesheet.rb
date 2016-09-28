class FlashcardControllerStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def table(st)
    st.background_color = color.gray
  end

  def flashcard_cell_height
    80
  end

  def flashcard_cell(st)
    # Style overall cell here
    st.background_color = color.light_gray
  end

  def cell_label(st)
    st.color = color.black
  end


  def subject_field(st)
    standard_form(st)

    st.frame = {l:0, t:0, w:rmq.device.width, h: 60}

    st.placeholder = "tap to chose a subject"
    st.corner_radius = 0
    st.color = color.black
    st.background_color = color.white
    st.font = font.large
    shadow(st)
  end

  def term_field(st)
    standard_form(st)

    st.frame = {l:0, t:0, w:rmq.device.width, h: 60}
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
    st.frame = {l:0, t:0, w:rmq.device.width, h: 95}
    st.corner_radius = 4
    st.font = font.standard
    st.background_color = color.white

    #st.border_style = UITextBorderStyleRoundedRect
    shadow(st)
  end

  def image_button(st)
    st.frame = {l:0, t:0, w:rmq.device.width, h: 60}
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

    st.frame = {l:0, t:0, w:rmq.device.width, h: 60}
    st.background_color = color.white
    #st.content_size = CGSizeMake(@screen[:width], 1160);
  end


  def mic_button(st)
    standard_form(st)
    shadow(st)

    st.background_color = color.default_blue
    st.color = color.white
    st.text = "Microphone"
    st.font = font.small
  end
  
  def scadule_button(st)
    standard_form(st)
    shadow(st)

    st.background_color = color.default_blue
    st.color = color.white
    st.text = "Scadule"
    st.font = font.small
  end

end
