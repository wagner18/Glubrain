class PickerLangFrom < UIViewController

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor
    @label = UILabel.new
    @label.text = "Number Selected:  0"
    @label.font = UIFont.boldSystemFontOfSize(18)
    @label.frame = [[20,100],[260,120]]
    @label.numberOfLines = 2
    @label.adjustsFontSizeToFitWidth = true
    view.addSubview(@label)

    @picker = UIPickerView.new
    @picker.frame = [[0, 183], [320, 162]]
    @picker.delegate = self
    @picker.dataSource = self
    view.addSubview(@picker)

  end

  def pickerView(pickerView, numberOfRowsInComponent:component)
    101
  end

  def pickerView(pickerView, titleForRow:row, forComponent:component)
    row.to_s
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, didSelectRow:row, inComponent:component)
    @label.text = "From:  #{row}"
  end

end