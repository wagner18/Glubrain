class MainController < UITabBarController

  def viewDidLoad
    super

    main_view_controller = MainViewController.alloc.initWithNibName(nil, bundle: nil)
    #main_view_controller.title = "Notes"
    main_view_navigation = UINavigationController.alloc.initWithRootViewController(main_view_controller)

    # flash_cards_controller = FlashCardsController.alloc.initWithNibName(nil, bundle: nil)
    # flash_cards_navigation = UINavigationController.alloc.initWithRootViewController(flash_cards_controller)

    flash_cards_controller = FlashcardController.alloc.initWithStyle(UITableViewStyleGrouped)
    flash_cards_navigation = UINavigationController.alloc.initWithRootViewController(flash_cards_controller)

    flashcard_screen = FlashcardScreen.new
    flashcard_navigation = UINavigationController.alloc.initWithRootViewController(flashcard_screen)

    list_controller = HomescreenController.alloc.initWithNibName(nil, bundle: nil)
    #list_controller.title = "List"
    list_navigation = UINavigationController.alloc.initWithRootViewController(list_controller)

    self.viewControllers = [main_view_navigation, flash_cards_navigation, flashcard_navigation, list_navigation]

    self

  end

end