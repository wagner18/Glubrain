class MainController < UITabBarController

  def viewDidLoad
    super

    main_view_controller = MainViewController.alloc.initWithNibName(nil, bundle: nil)
    main_view_controller.title = "Notes"

    main_view_navigation = UINavigationController.alloc.initWithRootViewController(main_view_controller)

    list_controller = HomescreenController.alloc.initWithNibName(nil, bundle: nil)
    list_controller.title = "List"

    list_navigation = UINavigationController.alloc.initWithRootViewController(list_controller)

    self.viewControllers = [main_view_navigation, list_navigation]

    self

  end

end