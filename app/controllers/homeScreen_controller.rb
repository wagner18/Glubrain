class HomescreenController < UITableViewController

  HOMESCREEN_CELL_ID = "HomescreenCell"

  def initWithNibName(name, bundle: bundle) 
    super

    self.tableView.initWithFrame(self.view.bounds, style: UITableViewStyleGrouped)

    self.tabBarItem =
      UITabBarItem.alloc.initWithTitle(
        "List",
        image: icon_image(:awesome, :bars, size: 24), 
        tag: 1)
    self
  end

  def viewDidLoad
    super

    @fields = {
      :search_label => rmq.append(UILabel, :search_label).get,
      :search_field => rmq.append(UITextView, :search_field).get #NextResponder = focus
    }

    rmq.append(UIButton, :submit_button).on(:touch) do |sender|
      search_image(@search_field.text)
    end

    load_data

    rmq.stylesheet = HomescreenControllerStylesheet

    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight

    view.tap do |table|
      table.delegate = self
      table.dataSource = self
      rmq(table).apply_style :table
    end

  end

  def load_data
    @data = 0.upto(rand(100)).map do |i| # Test data
      {
        name: %w(Lorem ipsum dolor sit amet consectetur adipisicing elit sed).sample,
        num: rand(100),
      }
    end
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    rmq.stylesheet.homeScreen_cell_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)

    data_row = @data[index_path.row]

    cell = table_view.dequeueReusableCellWithIdentifier(HOMESCREEN_CELL_ID) || begin
      rmq.create(HomescreenCell, :homeScreen_cell, reuse_identifier: HOMESCREEN_CELL_ID).get

    #   # If you want to change the style of the cell, you can do something like this:
    #   #rmq.create(HomescreenCell, :homeScreen_cell, reuse_identifier: HOMESCREEN_CELL_ID, cell_style: UITableViewCellStyleSubtitle).get
    end

    # cell ||= UITableViewCell.alloc.initWithStyle(
    #   UITableViewCellStyleDefault,
    #   reuseIdentifier:HOMESCREEN_CELL_ID)

    cell.update(data_row)
    cell
  end

  def tableView(table_view, numberOfRowsInSection: section)
    #@data.length

    sections[section].length
  end

  def sections

    @sections_name = ['Input', 'Historic']

    sections = [ @fields, @data]
  end

  def tableView(tableView, titleForHeaderInSection:section)
    
    @sections_name[section]
  end

  def numberOfSectionsInTableView(tableView) 
    self.sections.count
  end

  # def tableView(tableView, sectionForSectionIndexTitle: title, atIndex: index)
  #   sections.index title
  # end

  # def sectionIndexTitlesForTableView(tableView) 
  #   sections
  # end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

end
