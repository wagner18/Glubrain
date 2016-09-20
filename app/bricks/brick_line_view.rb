class BrickLineView < UIView


  def setup(parentView, orientation = "h", margin = 0, height = 0.5, color = UIColor.lightGrayColor)

    parentView.addSubview(self) if parentView
    parent_index = self.superview.subviews.index(self) - 1
    last_view = self.superview.subviews[parent_index]

    if(orientation == "h")
      x = last_view.frame.origin.x
      y = last_view.frame.origin.y + last_view.frame.size.height + 0.5
      width = last_view.frame.size.width

      self.frame = CGRectMake(x, y, width, height)

    elsif(orientation == "v")

      x = last_view.frame.origin.x - 1
      y = last_view.frame.origin.y
      width = height
      height = last_view.frame.size.height

      self.frame = CGRectMake(x, y, width, height)
    end

    self.backgroundColor = color
  end

end