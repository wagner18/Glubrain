class FlashcardScreen < PM::XLFormScreen

  def on_init
    icon = icon_image(:awesome, :file_text, size: 24)
    set_tab_bar_item(item: icon, title: "Flashcards")#, image_insets: [1,1,1,1])
    # set_tab_bar_item system_item: :more
    # :more, :favorites, :featured, :top_rated, :recents, :contacts,
    # :history, :bookmarks, :search, :downloads, :most_recent, :most_viewed 
  end

  title "Flashcards"
  stylesheet FlashcardScreenStylesheet

  form_options  required: :asterisks,
                on_save: :'save_form:',
                on_cancel: :cancel_form,
                auto_focus: true


  # Form definition
  def form_data

    subjects = [
      { id: 'language', name: 'Languange' },
      { id: 'math', name: 'Math' }
    ]

    [
      {
        title: 'Account information',
        footer: 'Some help text',
        #options: [:insert, :delete, :reorder],
        cells: [
          {
            title: 'Subjects',
            name: :subjects,
            type: :selector_push,
            appearance: appearance_style,
            options: Hash[subjects.map do |subject|
              [subject[:id], subject[:name]]
            end]
          },
          {
            name: :textview,
            type: :textview,
            placeholder: 'Enter a text',
            required: true
          },
          {
            title: 'Only letters',
            name: :letters,
            type: :text,
            appearance: appearance_style({
                alignment: :right
            }),
            validators: {
              regex: { regex: /^[a-zA-Z]+$/, message: 'Invalid name' }
            }
          },
          {
            title: 'One',
            name: :only_one,
            type: :text,
            appearance: appearance_style({
                alignment: :right
            }),
            validators: {
              custom: NumberValidator.new
            }
          },
          {
            title: 'Date an time',
            name: :datetime,
            type: :datetime_inline,
            appearance: appearance_style,
            properties: {
              min: NSDate.new
            }
          },
          {
            title: 'Click me',
            name: :click_me,
            type: :button,
            appearance: appearance_style,
            on_click: -> (cell) {
              mp "You clicked me"
            }
          },
          {
            title: 'Yes ?',
            name: 'check',
            type: :switch,
            appearance: appearance_style,
          },
          {
            title: 'Image',
            name: 'image',
            type: :text,
            image: "user",
            # appearance: appearance_style,
          },
          {
            title: 'Options',
            name: 'options',
            type: :selector_push,
            appearance: appearance_style,
            options: Hash[subjects.map do |subject|
              [subject[:id], subject[:name]]
            end],
            value: 'value_1',
            on_change: -> (old_value, new_value) {
              mp old_value: old_value,
                 new_value: new_value
            }
          },
          {
            title: 'iPad Options',
            name: 'ipad_options',
            type: :selector_popover,
            appearance: appearance_style,
            options: Hash[subjects.map do |subject|
              [subject[:id], subject[:name]]
            end],
            value: 'value_1',
          }

        ]
      },


      {
        name: 'images',
        cells: [
          {
            title: 'An image',
            name: :picture,
            type: :image,
            appearance: appearance_style,
            value: UIImage.imageNamed('icon-512@2x.png')
          }
        ]
      },

    ]

  end


  def save_form(values)
    dismiss_keyboard
    #mp on_save: values
    puts values
  end

  def cancel_form
    rmq(self).hide.remove
  end

  def appearance_style(hash = {})
    style = {
      font: UIFont.fontWithName('Helvetica Neue', size: 16.0),
      detail_font: UIFont.fontWithName('Helvetica Neue', size: 16.0),
      color: UIColor.grayColor,
      detail_color: UIColor.whiteColor,
      background_color: color.translucent_background,# UIColor.darkGrayColor
    }

    style = style.merge(hash)
    return style

  end

end


class TestValueTransformer < ProMotion::ValueTransformer

  def transformedValue(value)
    return nil if value.nil?

    str = []
    str << value['first_text'] if value['first_text']
    str << value['second_text'] if value['second_text']

    str.join(',')
  end
end

class NumberValidator < ProMotion::Validator
  def initialize
    @message = "Only 1 !!!"
  end

  def valid?(row)
    return nil if row.nil? or row.value.nil?
    row.value == "1"
  end
end

class MyCustomCell < PM::XLFormCell

  def update
    super

    self.data_cell ||= {}
    self.data_cell[:subtitle] = value

    set_subtitle
  end
end