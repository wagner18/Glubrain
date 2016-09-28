class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup

    # App grid, used by default throughout the applicaiton
    rmq.app.grid.tap do |g|
      g.content_left_margin = 10
      g.content_right_margin = 10
      g.content_top_margin = 74 
      g.content_bottom_margin = 10 
      g.num_columns =  12 
      g.column_gutter = 10 
      g.num_rows = 18 
      g.row_gutter = 10 
    end

    # Named fonts
    font_family = 'Helvetica Neue'
    font.add_named :very_large,     font_family, 56
    font.add_named :large,          font_family, 24 
    font.add_named :medium,         font_family, 18 
    font.add_named :standard,       font_family, 16 
    font.add_named :small,          font_family, 14 
    font.add_named :tiny,           font_family, 12 

    # Named colors
    color.add_named :white, "#FFFFFF"
    color.add_named :tint, '#438AF0' 
    color.add_named :gray, '#DDDDDD' 
    color.add_named :light_gray, '#EDEDED' 
    color.add_named :very_light_gray,'#F4F4F4'

    color.add_named :default_blue, '#005FB9'
    color.add_named :l_blue, '#6EA4BE'

    color.add_named :soft_green, '#64ad40'
    color.add_named :vary_soft_green, '#b8d98d'

    color.add_named :translucent_black, color.from_rgba(0, 0, 0, 0.6)
    color.add_named :translucent_white, color(hex: 'fff', a: 0.70)
    color.add_named :translucent_background, color(hex: 'fff', a: 0.40)
    color.add_named :battleship_gray,   '#7F7F7F'

    # Set other application-wide visual things, such as appearances:
    # SVProgressHUD.appearance.hudBackgroundColor = color.light_gray
    # SVProgressHUD.appearance.hudForegroundColor = color.black
  end

  # Some standard styles

  def standard_label(st)
    st.frame = {w: 40, h: 18}
    st.background_color = color.clear
    st.color = color.black
  end

  
  def standard_button(st)
    st.frame = {w: 40, h: 30}
    st.background_color = color.tint
    st.color = color.white
    st.corner_radius = 5 
    st.view.setTitleColor(color.gray, forState: UIControlStateHighlighted)
  end

  def standard_button_enabled(st)
    st.background_color = color.tint
    st.color = color.white
    st.enabled = true
  end

  def standard_button_disabled(st)
    st.background_color = color.gray
    st.color = color.white
    st.enabled = false
  end

  def standard_form(st)
    st.opacity = 0.60
  end

  def shadow(st)
    st.clips_to_bounds = true

    st.view.layer.tap do |l|
      l.shadowColor = color.black.CGColor
      l.shadowOpacity = 0.2
      l.shadowRadius = 1.0
      l.shadowOffset = [0.5, 2.0]
    end
  end

end
