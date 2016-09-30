class TestFormScreen < PM::XLFormScreen

  title "Form"

  form_options required: :asterisks,
               on_save: :'save_form:',
               #on_cancel: :cancel_form,
               auto_focus: true

  def form_data

    areas = [
      { id: 'value_1', name: 'Name 1' },
      { id: 'value_2', name: 'Name 2' },
      { id: 'value_3', name: 'Name 3' },
      { id: 'value_4', name: 'Name 4' },
    ]

    [

      {
        title: 'Account information',
        footer: 'Some help text',
        cells: [
          {
            title: 'Email',
            name: :email,
            type: :email,
            placeholder: 'Enter your email',
            required: true,
            validators: {
              email: true
            }
          },
          {
            title: 'Url',
            name: :url,
            type: :url,
            placeholder: 'Enter an url',
            required: true,
            validators: {
              url: true
            }
          },
          {
            title: 'textView',
            name: :textview,
            type: :textview,
            placeholder: 'Enter a text',
            required: true
          },
          {
            title: 'Only letters',
            name: :letters,
            type: :text,
            validators: {
              regex: { regex: /^[a-zA-Z]+$/, message: 'Invalid name' }
            }
          },
          {
            title: 'One',
            name: :only_one,
            type: :text,
            validators: {
              custom: NumberValidator.new
            }
          },
          {
            title: 'Click me',
            name: :click_me,
            type: :button,
            on_click: -> (cell) {
              mp "You clicked me"
            }
          },
          {
            title: 'Yes ?',
            name: 'check',
            type: :switch
          },
          {
            title: 'Image',
            name: 'image',
            type: :text,
            image: "user",
          },
          {
            title: 'Options',
            name: 'options',
            type: :selector_push,
            appearance: {
              font: UIFont.fontWithName('Helvetica Neue', size: 15.0),
              detail_font: UIFont.fontWithName('Helvetica Neue', size: 12.0),
              color: UIColor.greenColor,
              detail_color: UIColor.blueColor,
              background_color: UIColor.grayColor
            },
            options: Hash[areas.map do |area|
              [area[:id], area[:name]]
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
            options: Hash[areas.map do |area|
              [area[:id], area[:name]]
            end],
            value: 'value_1',
          },
          {
            title: 'Alignment',
            name: :align,
            type: :text,
            appearance: {
              alignment: :right
            }
          }
        ]
      },



      {
        cells: [
          {
            title: 'A slider',
            name: :slider,
            type: :slider,
            appearance: {
              "slider.tintColor" => UIColor.redColor
            },
            properties: {
              max: 100,
              min: 2,
              step: 4
            },
            # on_change: -> (old_value, new_value, row) {
            #   mp old_value: old_value,
            #      new_value: new_value
            #   if old_value != new_value
            #     row.setTitle("Slider at #{new_value}")
            #     self.reloadFormRow(row)
            #   end
            # }
          },
          {
            title: 'A date',
            name: :date,
            type: :date_inline
          },
          {
            title: 'Another date',
            name: :other_date,
            type: :date_inline,
            properties: {
              min: NSDate.new
            }
          },
          {
            title: 'Pin',
            name: :pin,
            type: :password,
            placeholder: 'Enter your 4-digit PIN',
            keyboard_type: :decimal_pad
          },
          {
            title: 'Multiple',
            name: :multiple,
            type: :multiple_selector,
            options: {
              :roses => 'Roses are #FF0000',
              :violets => 'Violets are #0000FF',
              :base => 'All my base',
              :belong => 'are belong to you.'
            }
          },
          {
            title: 'Custom cell',
            name: :custom_cell,
            cell_class: MyCustomCell,
            value: 'Hello',

            # PM::TableViewCell stuff
            height: 86,
            selection_style: :none,
            image: {
              image: 'icon-60@2x.png',
              size: 30
            }
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
            value: UIImage.imageNamed('icon-512@2x.png')
          }
        ]
      },
      {
        title: 'Multi-value',
        name: 'multi',
        options: [:insert, :delete, :reorder],
        cells: [
          {
            title: 'Some text',
            name: :some_text,
            type: :text
          }
        ]
      },
      {
        title: 'Multi-value with XLFormSectionInsertModeButton',
        name: 'multi',
        options: [:insert, :delete, :reorder],
        insert_mode: :button,
        cells: [
          {
            title: 'Some text',
            name: :some_text,
            type: :text
          }
        ]
      },
      {
        title: 'Subcells',
        name: :sub_cells,
        options: [:insert, :delete, :reorder],
        cells: [
          {
            title: 'Subcell',
            name: :sub_cell,
            cells: [
              {
                title: 'Some text',
                name: :some_text,
                type: :text
              },
              {
                title: 'Other text',
                name: :some_other_text,
                type: :text
              }
            ]
          }
        ]
      },
      {
        title: 'Subcells with custom transformer',
        name: :sub_cells,
        cells: [
          {
            title: 'Subcell',
            name: :sub_cell,
            value_transformer: TestValueTransformer,
            cells: [
              {
                title: 'First text',
                name: :first_text,
                type: :text
              },
              {
                title: 'Second text',
                name: :second_text,
                type: :text
              }
            ]
          }
        ]
      },
      {
        title: 'Hide and seek',
        cells: [
          {
            title: 'Switch me',
            type: :switch,
            name: :hide_and_seek,
            value: true
          },
          {
            title: 'Switch is off',
            name: :show_me,
            type: :text,
            hidden: { name: :hide_and_seek, is: :equal, value: false },
            value: 'hi !'
          },
          {
            title: 'hello ?',
            name: :hide_me,
            type: :info,
            hidden: ':show_me not contains "hello"'
          },
          {
            title: 'Value 1 ?',
            name: :show_me_selector,
            type: :text,
            hidden: { name: :options, is: :equal, value: 'value_1', options: true },
            value: 'is selected !'
          },
        ]
      },
      {
        title: 'Color chooser',
        cells: [
          {
            title: 'Color',
            type: :color,
            name: :color,
            value: UIColor.blueColor
          }
        ]
      }
    ]
  end

  def save_form(values)
    mp on_save: values
  end

  def cancel_form
    rmq(self).hide.remove
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