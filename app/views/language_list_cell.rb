class LanguageListCell < UITableViewCell

  def rmq_build
    q = rmq(self.contentView)

    # Customize your cell: Add your subviews, init stuff here
    # @foo = q.append!(UILabel, :foo)

    # Or use the built-in table cell controls, if you don't use
    # these, they won't exist at runtime
    # @image = q.build!(self.imageView, :cell_image)
    # @detail = q.build!(self.detailTextLabel, :cell_label_detail)
    @name = q.build!(self.textLabel, :cell_label)
  end

  def prepareForReuse
    @reused = true
  end

  def update(data)
    # Update data here
    @name.text = data[:lang]
  end

end
