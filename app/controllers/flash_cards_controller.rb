class FlashCardsController < UIViewController

  def initWithNibName(name, bundle: bundle) 
    super

    rmq.stylesheet = FlashCardsControllerStylesheet
    rmq(self.view).apply_style :root_view

    icon = icon_image(:awesome, :file_text, size: 24)
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Flashcards", image: icon, tag: 1)

    self
  end

  def viewDidLoad


  end



end