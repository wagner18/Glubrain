class RequestApi

  def initialize(base_url)
    @base_url = base_url
  end

  def get(path)
    @base_url = @base_url + path
    @request = create_request
    set_method(:GET)
  end

  def post(params)
    @request = create_request
    set_method(:POST)
    add_params(@request, params)
  end

  def set_method(method)
    @request.setHTTPMethod(method.to_s.upcase)
  end

  def set_format(format = "HTML")
    if(format == "HTML")
      @request.addValue("text/html", forHTTPHeaderField: "Content-Type")
      @request.addValue("text/html", forHTTPHeaderField: "Accept")
    elsif(format == "JSON")
      @request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      @request.addValue("application/json", forHTTPHeaderField: "Accept")
    elsif(format == "URLENCODED")
      @request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
      @request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
    end
  end

  def add_header_params(field, content)
    @request.addValue(content, forHTTPHeaderField: field)
  end

  def add_params(request, params)
    data = create_json_data(params)
    request.setHTTPBody(data)
  end

  def resume(&block)
    create_task(@request, &block).resume
  end

  private
  def config
    NSURLSessionConfiguration.defaultSessionConfiguration
  end

  def session
    NSURLSession.sessionWithConfiguration(config)
  end

  def create_request()
    url = NSURL.URLWithString(@base_url)
    request = NSMutableURLRequest.requestWithURL(url)
    request
  end


  def create_json_data(params)
    json = NSJSONSerialization.dataWithJSONObject(params, options: 0, error: nil)
    json = json.to_str.gsub(/\\\/\\\//, '//')
    #json = NSData.dataWithData(json, encoding: NSUTF8StringEncoding)
  end

  def create_task(request, &block)
    if block_given?
      session.dataTaskWithRequest(request, completionHandler: -> (data, response, error){
        block.call(APIResponse.new(data, response, error))
      })
    else
      session.dataTaskWithRequest(request)
    end
  end

  def connection(request)
    queue = NSOperationQueue.alloc.init
    NSURLConnection.sendAsynchronousRequest(
      request, 
      queue: queue, 
      completionHandler: lambda do |response, data, error|
          puts request.inspect
          puts data.inspect
      end
      )
  end


  # wrap the response to be more ruby likily
  class APIResponse

    attr_reader :success, :data, :error

    def initialize(data, response, error)
      @success = (200..300).include?(response.statusCode)
      @data = NSJSONSerialization.JSONObjectWithData(data, options: 0, error: nil)
      @error = error
    end

    def sucessful?
      @success
    end

  end

end
