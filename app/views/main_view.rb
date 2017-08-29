class MainView < UIView

    attr_accessor :delegate

    def rmq_build

        rmq_self = rmq(self)
        rmq_self.apply_style :main_view

        self.frame = self.superview.bounds
        self.setUserInteractionEnabled(true)

        # Create your UIViews here
        @from_button = rmq_self.append(UIButton, :from_button).tag(:main_form).on(:touch) do |sender|
            puts "translate from : >>>"
            language_picker("from")
        end

        @swap_button = rmq_self.append(UIButton, :swap_button).tag(:main_form).on(:touch) do |sender|
            rmq(:swap_button).animations.throb
            swap_language
            puts "Swap to: >>>"
        end
       
        @to_button = rmq_self.append(UIButton, :to_button).tag(:main_form).on(:touch) do |sender|
            puts "translate to : >>>"
            language_picker("to")
        end

        @source_field = rmq_self.append(UITextView, :source_field ).tag(:main_form).get #NextResponder = focus
        @source_field.delegate = self
        # rmq(@source_field)#:length, min_length: 2, max_length: 50)
        # rmq(@source_field).on(:invalid) do |invalid|
        #     App.alert("This field is invalid")
        # end

        @clear_button = rmq_self.append(UIButton, :clear_button).tag(:main_form).on(:touch) do |sender|
            rmq(:clear_button).animations.sink_and_throb
            clean_source_field
        end

        @translate_button = rmq_self.append(UIButton, :translate_button).tag(:main_form).on(:touch) do |sender|
            rmq(:translate_button).animations.sink_and_throb
            translate
        end

        @result_field = rmq_self.append(UITextView, :result_field).tag(:main_form).get


        # Hold the result from the translation options if there is some.
        # @result_options = rmq_self.append(UITextView, :result_options).tag(:main_form)
        # @result_options.hide
        # @result_options = @result_options.get

        # Image conteiner
        @image_conteiner = rmq_self.append(UIView, :image_conteiner).tag(:main_form)
        @image_conteiner.hide


        #Buttons layer
        rmq_self.append(UIButton, :cam_button).tag(:main_form).on(:touch) do |sender|
          image_picker
        end

        rmq_self.append(UIButton, :mic_button).tag(:main_form).on(:touch) do |sender|
          media_picker
        end

        rmq_self.append(UIButton, :schedule_button).tag(:main_form).on(:touch) do |sender|
          schedule_flashcard
        end

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

    def language_picker(label)
        if self.delegate.respond_to?("language_picker")
            self.delegate.language_picker(label)
        end
    end

    def swap_language
        if self.delegate.respond_to?("swap_language")
            self.delegate.swap_language
        end
    end

    def clean_source_field
        if self.delegate.respond_to?("clean_source_field")
            self.delegate.clean_source_field
        end
    end

    def translate
        if self.delegate.respond_to?("translate")
            self.delegate.translate
        end
    end

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

    def schedule_flashcard
        if self.delegate.respond_to?("schedule_flashcard")
            self.delegate.schedule_flashcard
        end
    end


end

# To style this view include its stylesheet at the top of each controller's
# stylesheet that is going to use it:
#   class SomeStylesheet < ApplicationStylesheet
#     include MainScreenStylesheet

# Another option is to use your controller's stylesheet to style this view. This
# works well if only one controller uses it. If you do that, delete the
# view's stylesheet with:
#   rm app/stylesheets/views/main_screen.rb
