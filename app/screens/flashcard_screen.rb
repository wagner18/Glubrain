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
                on_save: :'save_form:'
                #on_cancel: :cancel_form,
                #auto_focus: true


  # Form definition
  def form_data

    [
      {
        title: 'Enter your flashcard informations',
        footer: 'Set up your flashcard information with the question and the answer to be able schedule it as a riminder',
        #options: [:insert, :delete, :reorder],
        cells: [
          {
            title: 'Question Label',
            name: :subjects,
            type: :selector_push,
            view_controller_class: FlashcardQuestionLabelTable,
            appearance: appearance_style
            
            # options: Hash[load_data.map do |subject|
            #     [subject[:id], subject[:name]]
            # end]
            # on_change: -> (old_value, new_value) {
            #   mp old_value: old_value,
            #      new_value: new_value
            # }
          },
          {
            title: 'Question Object',
            name: :only_one,
            type: :text,
            #required: true,
            appearance: appearance_style({
                alignment: :right
            })
          },
          {
            # title: "Question answer",
            name: :description,
            type: :textview,
            placeholder: 'Enter your question answer'
            #required: true
          }
        ]
      },

      # Set the image cell to add image
      {
        title: '',
        name: 'Media',
        #options: [:insert, :delete, :reorder],
        cells: [
          {
            title: 'An image',
            name: :picture,
            type: :image,
            appearance: appearance_style,
            value: UIImage.imageNamed('icon-512@2x.png')
          },
          {
            title: 'Audio record',
            name: :audio_record,
            type: :image,
            appearance: appearance_style,
            value: UIImage.imageNamed('icon-512@2x.png')
          }
        ]
      },

      # Schedule section

      {
        title: 'Remind Schedule',
        footer: 'Some help text',
        #options: [:insert, :delete, :reorder],
        cells: [
           {
            title: 'Daily Frequency',
            name: :note_frequency,
            type: :selector_picker_view_inline,
            appearance: appearance_style,
            value: 'Once a day',
            options: {
              :one => "Once a day",
              :two => "Twice a day",
              :three => "Three times a day",
              :four => "Four times a day",
            }

          },
          {
            title: 'Remind me',
            name: :repeat_frequency,
            type: :multiple_selector,
            appearance: appearance_style,
            #value: "Never",
            options: {
              :sunday => "Every Day",
              :monday => "Every Week",
              :tuesday => "Every 2 Weeks",
              :wednesday => "Every Month",
              :wednesday => "Every Year"
            }

          },
          {
            title: 'Stop Remind',
            name: :stop_remind,
            type: :selector_push,
            appearance: appearance_style,
            cells: [
              {
                title: 'Repeat Forever',
                name: :reapet_forever,
                type: :check,
                value: true,
                appearance: appearance_style
              },
              {
                title: 'Stop date',
                name: :stop_remind_date,
                type: :date_inline,
                appearance: appearance_style
              }
            ]
          },
          {
            title: 'Turn off?',
            name: 'rimind_on',
            type: :switch,
            value: true, 
            appearance: appearance_style
          }

        ]
      }

    ]

  end

  def load_data
    subjects = [
      { id: '1', name: "what's means?" },
      { id: '2', name: "What's the translation of the word below?" }
    ]
  end


  def save_form(values)
    dismiss_keyboard
    puts values.inspect
    mp on_save: values
  end

  def cancel_form
    rmq(self).hide.remove
  end

  def appearance_style(hash = {})
    style = {
      font: UIFont.fontWithName('Helvetica Neue', size: 16.0),
      detail_font: UIFont.fontWithName('Helvetica Neue', size: 16.0),
      color: UIColor.grayColor,
      detail_color: UIColor.blackColor,
      background_color: color.translucent_background,# UIColor.darkGrayColor
    }

    style = style.merge(hash)
    return style

  end

end



class CustomCell < PM::XLFormCell

  def initWithStyle(style, reuseIdentifier: reuse_identifier)
    super

    rmq_self = rmq(self)
    rmq_self.apply_style :custom_cell

    self
  end

  def update
    super

    self.data_cell ||= {}
    self.data_cell[:subtitle] = value

    set_subtitle
  end
end