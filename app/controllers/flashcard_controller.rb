class FlashcardController < UITableViewController

  FLASHCARD_CELL_ID = "FlashcardCell"


  def initWithStyle(tableViewStyleGrouped)
    super

    self.tableView.initWithFrame(self.view.bounds, style: tableViewStyleGrouped)
    self.tableView.allowsSelectionDuringEditing = true
    #self.view.setEditing true, animated: true

    icon = icon_image(:awesome, :file_text, size: 24)
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Exemplo", image: icon, tag: 1)

    self
  end

  def viewDidLoad
    super

    rmq.stylesheet = FlashcardControllerStylesheet

    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight

    view.tap do |table|
      table.delegate = self
      table.dataSource = self
      rmq(table).apply_style :table
    end

    load_data

  end

  def load_data

    #define cell by cell
    @cell = []
    @cell_heigth = []

    @cell[0] = rmq.create(FlashcardCell, :flashcard_cell, reuse_identifier: FLASHCARD_CELL_ID, cell_style: UITableViewCellStyleValue1).get
    @cell[0].accessoryType = UITableViewCellAccessoryDisclosureIndicator
    @cell[0].textLabel.text = "Select a Subject"
    @cell[0].detailTextLabel.text = "language"
    #@cell[0].imageView.image = icon_image(:ion, :image)
    @cell_heigth[0] = 60

    @cell[1] = rmq.create(FlashcardCell, :flashcard_cell, reuse_identifier: FLASHCARD_CELL_ID, cell_style: UITableViewCellStyleSubtitle).get
    #@cell[1].accessoryType = UITableViewCellAccessoryDisclosureIndicator
    @cell[1].contentView.addSubview(rmq.build(UITextField, :term_field).get)
    @cell_heigth[1] = 60

    @cell[2] = rmq.create(FlashcardCell, :flashcard_cell, reuse_identifier: FLASHCARD_CELL_ID, cell_style: UITableViewCellStyleSubtitle).get
    #@cell[2].accessoryType = UITableViewCellAccessoryDisclosureIndicator
    @cell[2].contentView.addSubview(rmq.build(UITextView, :body_field).get)
    @cell_heigth[2] = 100

  end

  def sections
    sections_name = ['form']
  end

  def numberOfSectionsInTableView(tableView) 
    self.sections.count
  end

  def tableView(tableView, titleForHeaderInSection:section)
    sections[section]
  end

  def tableView(table_view, numberOfRowsInSection: section)
    @cell.length
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)

    #@cell[index_path.row].contentView.subviews[0].frame.size.height
    #rmq.stylesheet.flashcard_cell_height
    puts @cell_heigth[index_path.row]

    @cell_heigth[index_path.row]
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    cell = @cell[index_path.row]

    # cell = table_view.dequeueReusableCellWithIdentifier(FLASHCARD_CELL_ID) || begin
    #   #rmq.create(FlashcardCell, :flashcard_cell, reuse_identifier: FLASHCARD_CELL_ID).get
    #   # If you want to change the style of the cell, you can do something like this:
    #   rmq.create(FlashcardCell, :flashcard_cell, reuse_identifier: FLASHCARD_CELL_ID, cell_style: UITableViewCellStyleSubtitle).get
    # end

    #cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator

    label = rmq.build(UILabel).get
    label.text = "label: "
    #cell.textLabel = label

    #cell.update(data_row)
    cell
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end
