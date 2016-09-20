class LayoutView 

  def x(view)
    view.frame.origin.x if view
  end

  def y(view)
    view.frame.origin.y if view
  end

  def width(view)
    view.frame.size.width if view
  end

  def height(view)
    view.frame.size.height if view
  end

end