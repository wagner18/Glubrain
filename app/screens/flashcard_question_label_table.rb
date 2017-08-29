class FlashcardQuestionLabelTable < PM::TableScreen

  attr_accessor :rowDescriptor

  title "Tasks"
  refreshable
  searchable placeholder: "Question Labels", no_results: "Sorry, Try Again!"
  row_height :auto, estimated: 44

  def on_load
    #@tasks = []
    #load_async
  end

  def table_data
    [{
      title: "Northwest States",
      cells: [
        { title: "Switch With Action",
        accessory: {
            view: :switch,
            value: true, # switched on
            action: :foo
          }
        },
        { title: "what's means the word?", 
          action: :visit_state, 
          arguments: { state: @oregon }
        },
        { title: "How pronous this word?", 
          action: :visit_state, 
          arguments: { state: @washington }
        }
      ]
    }]
  end

  def on_refresh
    #load_async
  end

  def load_async
    # Assuming we're loading tasks from some cloud service

    @tasks = [
              {
                title: "Task 01",
                subtitle: "something sdf dsf",
                action: :edit_task,
                arguments: { task: task }
              },
              {
                title: "Task 02",
                subtitle: "something sdf sd",
                action: :edit_task,
                arguments: { task: task }
              },
              {
                title: "Task 03",
                subtitle: "something fdfsd",
                action: :edit_task,
                arguments: { task: task }
              }
      ]


      stop_refreshing
      update_table_data

  end

end