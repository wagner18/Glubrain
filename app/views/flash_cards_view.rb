class FlashCardsView < UIView

    attr_accessor :delegate

    def rmq_build

        rmq_self = rmq(self)
        rmq_self.stylesheet = FlashCardsViewStylesheet
        rmq_self.apply_style :root_view

        self.frame = self.superview.bounds
        self.setUserInteractionEnabled(true)

        rmq_view_container = rmq_self.append(UIScrollView, :view_container)


        @subject_button = rmq_view_container.append(UIButton, :subject_button).tag(:flashcards_form).on(:touch) do |sender|
          App.alert("List of Subjects")
        end

        @term_field = rmq_view_container.append(UITextField, :term_field).tag(:flashcards_form).get
        @term_field.delegate = self

        @body_field = rmq_view_container.append(UITextView, :body_field).tag(:flashcards_form).get

        @image_button = rmq_view_container.append(UIButton, :image_button).tag(:flashcards_form).on(:touch) do |sender|
            rmq(:image_button).animations.sink_and_throb
            media_picker
        end


        # Image conteiner
        @image_conteiner = rmq_view_container.append(UIView, :image_conteiner).tag(:flashcards_form)
        @image_conteiner.hide


    end


    def textViewDidBeginEditing(textView)
        if textView.text == "tap to enter text"
            textView.text = ""
            textView.textColor = UIColor.blackColor
        end
    end

    def textViewDidEndEditing(textView)
        textView.resignFirstResponder
    end
    # def textFieldShouldReturn(textField)
    #     textField.resignFirstResponder
    #     return true
    # end

    def image_picker
        if self.delegate.respond_to?("image_picker")
            self.delegate.image_picker
        end
    end

    def media_picker
        if self.delegate.respond_to?("media_picker")
            self.delegate.media_picker
        end
    end

end
