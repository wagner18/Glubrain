# //
# //  AppDelegate.rb
# //  Gluebrain
# //
# //  Created by WAGNER BORBA on 9/16/16.
# //  Copyright © 2016 WAGNER BORBA. All rights reserved.
# //

class AppDelegate

  include CDQ

  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    cdq.setup

    mtranslator_init

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    tab_controller = MainController.new
    
    # main_controller.view.addSubview(notes_view_list)

    @window.rootViewController = tab_controller
    @window.makeKeyAndVisible
    true
  end

  # Remove this if you are only supporting portrait
  def application(application, willChangeStatusBarOrientation: new_orientation, duration: duration)
    # Manually set RMQ's orientation before the device is actually oriented
    # So that we can do stuff like style views before the rotation begins
    rmq.device.orientation = new_orientation
  end

  def mtranslator_init
    client_translator = MicrosoftTranslator::AzureAuthentication.new()
  end

end
