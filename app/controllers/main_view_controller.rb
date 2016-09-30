class MainViewController < UIViewController

  attr_accessor :to_translate_text, :trans_from, :trans_to

  def initWithNibName(name, bundle: bundle) 
    super

    rmq.stylesheet = MainViewControllerStylesheet
    rmq(self.view).apply_style :root_view

    icon = icon_image(:awesome, :globe, size: 24)

    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Translator", image: icon, tag: 1)
    self
  end

  #Set the delegate for the MainView
  # def loadView
  # end


  def viewDidLoad
    super

    #init_navigation
    self.title = 'Translator'

    @main_view = MainView.new
    @main_view.delegate = self

    rmq.append(@main_view)

    init_user_default_information

  end


  def init_navigation

    self.title = 'Translator'
    self.navigationItem.tap do |nav|
      nav.leftBarButtonItem = 
        UIBarButtonItem.alloc.initWithBarButtonSystemItem(
          UIBarButtonSystemItemAction,
          target: self, action: :nav_left_button)
      nav.rightBarButtonItem = 
        UIBarButtonItem.alloc.initWithBarButtonSystemItem(
          UIBarButtonSystemItemRefresh,
          target: self, action: :nav_right_button)
    end

  end

  # Initialize the user default informations
  def init_user_default_information

    # set up the language from the UserDefaults
    default_language = App::Persistence['translate_options']
    if default_language && default_language.length > 0

      @trans_from = default_language[0][:cod]
      rmq(:from_button).get.setTitle(default_language[0][:lang], forState:UIControlStateNormal)

      @trans_to = default_language[1][:cod]
      rmq(:to_button).get.setTitle(default_language[1][:lang], forState:UIControlStateNormal)

    else

      @trans_from = "en"
      rmq(:from_button).get.setTitle('English', forState:UIControlStateNormal)

      @trans_to = 'pt'
      rmq(:to_button).get.setTitle("Portuguese", forState:UIControlStateNormal)

      #(default_language ||= []) <<  [@trans_from, "English"]
      default_language = []
      default_language << {:cod => @trans_from, :lang => "English"}
      default_language << {:cod => @trans_to, :lang => "Portuguese"}
      App::Persistence['translate_options'] = default_language

    end

  end

  def language_picker(source_action)

    lang_controller = LanguageListController.new(source_action)
    lang_controller.delegate = self
    lang_controller.title = "Translate #{source_action}"

    leftButton = UIBarButtonItem.alloc.initWithTitle("Cancel",
      style: UIBarButtonItemStyleBordered,
      target:self,
      action:'dismiss_language_picker')
    lang_controller.navigationItem.rightBarButtonItem = leftButton

    lang_navigation = UINavigationController.alloc.initWithRootViewController(lang_controller)

    self.presentViewController(lang_navigation, animated:true, completion: lambda {})

  end

  def dismiss_language_picker
    self.dismissViewControllerAnimated(true, completion: lambda{})
  end


  # setup the new language and reexecute the translate method to apply the changes
  def set_language(data)

    if data[:source_action] == 'from'
      @trans_from = data[:cod]

      button_from = rmq(:from_button)
      button_from.get.setTitle(data[:lang], forState:UIControlStateNormal)
      button_from.animations.sink_and_throb

    elsif data[:source_action] == 'to'
      @trans_to = data[:cod]

      button_to = rmq(:to_button)
      button_to.get.setTitle(data[:lang], forState:UIControlStateNormal)
      button_to.animations.sink_and_throb
    end

    if @to_translate_text
      translate
    end
  end


  def swap_language

    language_data = App::Persistence['translate_options']
    if language_data && !language_data.empty?

      puts language_data.inspect

      @trans_from = language_data[1][:cod]
      rmq(:from_button).get.setTitle(language_data[1][:lang], forState:UIControlStateNormal)

      @trans_to = language_data[0][:cod]
      rmq(:to_button).get.setTitle(language_data[0][:lang], forState:UIControlStateNormal)

      swaped_language = []
      swaped_language << language_data[1]
      swaped_language << language_data[0]
      App::Persistence['translate_options'] = swaped_language

    end

  end

  # Translate the given text using Mycrosoft API and AFMotion
  def translate

    #text = NSURL.URLWithString(text)
    source_field = rmq(:source_field).get
    text = source_field.text
    @to_translate_text = text ? text.gsub(/\s/, "%20") : nil

    # Hide the keybord after the user touch the botton translate
    source_field.resignFirstResponder

    if !@to_translate_text.nil? && !@to_translate_text.empty?

      client_translator = MicrosoftTranslator::Client.new()
      res = client_translator.alternative_translation(@to_translate_text, @trans_from, @trans_to) do |response|

        result_field = rmq(:result_field).get

        translate_result = BW::JSON.parse(response.object)

        first_return = translate_result["Translations"][0]
        result_field.text = first_return["TranslatedText"]

        # Set the alternative translation to the container
        # result_options = rmq(:result_options)
        # if translate_result["Translations"].length > 1

        #   set_alternative_translation(result_options.get, text, translate_result["Translations"])
        #   result_options.show
        # else
        #   result_options.hide
        # end

        puts first_return.inspect

        # Get images of the subject through the web
        search_image(text)

      end

    end
  end

  # Set the alternatice tralsation if exist
  def set_alternative_translation(container, text, alternatives_text)

    alternatives_text.delete_at(0)

    puts alternatives_text.inspect

    text_result = "Alternative Translation for : #{text}
    "
    alternatives_text.each do |txt|
      text_result += "
      #{text}: #{txt['TranslatedText']}"
    end

    container.text = text_result

  end

  # Set up the image picker ofr memocard
  def image_picker

    # Uses the photo library
    BW::Device.camera.any.picture(media_types: [:movie, :image]) do |result|
      image_view = UIImageView.alloc.initWithImage(result[:original_image])
    end

  end

  def media_picker

    local_file = NSURL.fileURLWithPath(File.join(NSBundle.mainBundle.resourcePath, 'test.mp3'))
      BW::Media.play(local_file) do |media_player|
        media_player.view.frame = [[10, 360], [100, 100]]
        self.view.addSubview(media_player.view)
      end
  end


  def search_image(query)
    if query && (query != '')

      query = query.gsub(/\s/, '%20')
      url = "https://secure.flickr.com/search/?q=#{query}&s=int"

      rmq.animations.start_spinner

      BW::HTTP.get(url) do |result|

        if result.body

          html = result.body.to_str

          #url("//c8.staticflickr.com/3/2365/2385191991_53e2ed8af9.jpg")
          #https://www.google.com/search?q=carros&tbm=isch

          images = html.scan(/url\((.+?\.jpg)\)/).map do |img|
            img.first
          end

          open_images_controller(images) if images.length > 0
          rmq.animations.stop_spinner
        end

      end
    end
  end


  def open_images_controller(images)

    image_conteiner = rmq(:image_conteiner)
    image_conteiner.show
    image_conteiner = image_conteiner.get

    collection_view = ImagesView.alloc.initWithFrame(CGRectMake(0,0, image_conteiner.frame.size.width, image_conteiner.frame.size.height))
    collection_view.images_urls = images

    image_conteiner.addSubview(collection_view)
    #self.navigationController.pushViewController(controller, animated:true)
  end

  def schedule_flashcard
    test_screen = TestFormScreen.new(nav_bar: true)
    self.navigationController.pushViewController(test_screen, animated:true)
  end


  # # Remove these if you are only supporting portrait
  # def supportedInterfaceOrientations
  #   UIInterfaceOrientationMaskAll
  # end
  # def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
  #   # Called before rotation
  #   rmq.all.reapply_styles
  # end
  # def viewWillLayoutSubviews
  #   # Called anytime the frame changes, including rotation, and when the in-call status bar shows or hides
  #   #
  #   # If you need to reapply styles during rotation, do it here instead
  #   # of willAnimateRotationToInterfaceOrientation, however make sure your styles only apply the layout when
  #   # called multiple times
  # end
  # def didRotateFromInterfaceOrientation(from_interface_orientation)
  #   # Called after rotation
  # end

end


__END__

# You don't have to reapply styles to all UIViews, if you want to optimize,
# another way to do it is tag the views you need to restyle in your stylesheet,
# then only reapply the tagged views, like so:
def logo(st)
  st.frame = {t: 10, w: 200, h: 96}
  st.centered = :horizontal
  st.image = image.resource('logo')
  st.tag(:reapply_style)
end

# Then in willAnimateRotationToInterfaceOrientation
rmq(:reapply_style).reapply_styles

