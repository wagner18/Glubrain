class LanguageListController < UITableViewController

  attr_accessor :delegate, :source_action
  LANGUAGE_CELL_ID = "LanguageCell"

  def initialize(source_action)
    @source_action = source_action
  end

  def viewDidLoad
    super

    load_data

    rmq.stylesheet = LanguageListControllerStylesheet

    view.tap do |table|
      table.delegate = self
      table.dataSource = self
      rmq(table).apply_style :table
    end

    @search_controller = UISearchController.alloc.initWithSearchResultsController(nil)
    #@search_controller.searchResultsUpdater = self
    @search_controller.searchBar.delegate = self
    @search_controller.searchBar.sizeToFit

    @search_controller.dimsBackgroundDuringPresentation = false

    @search_controller.hidesNavigationBarDuringPresentation = true

    self.definesPresentationContext = true
    self.tableView.tableHeaderView = @search_controller.searchBar
    

    #self.autoresizingMask = UIViewAutoresizingFlexibleHeight
  end

  def load_data
    @data = []
    language_list = Languages.new
    language_list.list.each do |cod, lang|
      @data << {cod: cod, lang: lang}
    end
  end

  def tableView(table_view, numberOfRowsInSection: section)
    @data.length
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    rmq.stylesheet.Language_cell_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    data_row = @data[index_path.row]

    cell = table_view.dequeueReusableCellWithIdentifier(LANGUAGE_CELL_ID)
    cell ||= rmq.create(LanguageListCell, :Language_cell, reuse_identifier: LANGUAGE_CELL_ID).get
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    # If you want to change the style of the cell, you can do something like this:
    #rmq.create(LanguageCell, :Language_cell, reuse_identifier: LANGUAGE_CELL_ID, cell_style: UITableViewCellStyleSubtitle).get
    
    cell.update(data_row)
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath: index_path) 

    tableView.deselectRowAtIndexPath(index_path, animated: true) 
    data = @data[index_path.row]

    self.dismissViewControllerAnimated(true, completion: lambda{

      language_data = App::Persistence['translate_options']
      if language_data

        new_data = []
        new_data[0] = language_data[0]
        new_data[1] = language_data[1]

        if @source_action == "from"
          new_data[0] = data
        elsif @source_action == "to"
          new_data[1] = data
        end

        App::Persistence['translate_options'] = new_data

      end
      

      data[:source_action] = @source_action

      if self.delegate.respond_to?("set_language")
          self.delegate.set_language(data)
      end

    })

  end


  # def tableView(tableView, editActionsForRowAtIndexPath:indexPath)
  # # return an array of UITableViewRowAction
  # end


  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end



end
