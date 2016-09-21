module MicrosoftTranslator

  # require 'afmotion'
  # require 'bubblewrap'

  class Client

    attr_accessor :result

    def initialize
      #raise "client_id must be a string" unless @client_id.is_a?(String)
      #raise "client_secret must be a string" unless @client_secret.is_a?(String)
      @auth = AzureAuthentication.new
    end


    def translate(text, from_lang, to_lang, &block)

      trans_url = "http://api.microsofttranslator.com"
      trans_params = "/v2/Http.svc/Translate?text=#{text}&from=#{from_lang}&to=#{to_lang}"
      access_token = "Bearer " + @auth.token

      # client = AFMotion::SessionClient.build(trans_url) do |client|
      #   client.session_configuration :default
      #   client.header "Content-Type", "application/json"
      #   client.header "Accept", "application/json"
      #   client.header "Authorization", access_token
      #   client.response_serializer :http
      # end

      client = set_client(trans_url, :http)

      client.headers["Content-Type"] = "application/json"
      client.headers["Accept"] = "application/json"

      # Execute the request setted up in the Client Session
      client.get(trans_params) do |response|

        if response.success?

          # get_translation_options(text, from_lang, to_lang) do |opts|
          #   puts opts.inspect
          # end

          block.call(response.object)
        else
          puts response.error.localizedDescription.inspect
          App.alert("Something wrong tranlating the text: #{text}")
        end
      end

      #puts "Result of the translation is #{@result}"
    end

    #http://api.microsofttranslator.com/V2/Ajax.svc/GetTranslations?appId=31C738345474CF52FD6F313331A7B00837031F17&text=either%20I&from=en&to=pt&maxTranslations=5
    # Method to retrieves an array of translations for a given language pair from the store and the MT engine
    def alternative_translation(text, from_lang, to_lang, &block)

      trans_url = "http://api.microsofttranslator.com"
      trans_path = "/V2/Ajax.svc/GetTranslations?text=#{text}&from=#{from_lang}&to=#{to_lang}&maxTranslations=5"

      client = set_client(trans_url, :http)

      client.headers["Content-Type"] = "application/json"#text/plain"
      client.headers["Accept"] = "application/json"#text/plain"

      client.post(trans_path) do |response|

        if response.success?
          block.call(response)
        else
          puts response.error.localizedDescription.inspect
          App.alert("Something wrong tranlating the text: #{text}")
        end

      end

    end


    def get_language_names(&block)

      #http://api.microsofttranslator.com/V2/Http.svc/GetLanguagesForTranslate
      path = "/V2/Http.svc/GetLanguagesForTranslate"
      access_token = "Bearer " + @auth.token
      connection = set_client("http://api.microsofttranslator.com", :xml)
      connection.get(path) do |response|

        if response.success?
          res_array = get_xml_content(response.object)
          con2 = set_client("http://api.microsofttranslator.com/V1/Http.svc/GetLanguageNames", :xml)
          con2.post("/",res_array) do |result|
            if result.success?
              puts result.body.inspect
            else
              puts result.error.localizedDescription.inspect
              App.alert("Something wrong with taking the name of tha languages")
            end
          end
          block.call(response.object)
        else
          puts response.error.localizedDescription.inspect
          App.alert("Something wrong getting the list of language")
        end
      end

    end

    def parse_xml(xml)
      # xml_doc = Nokogiri::XML(xml)
      # xml_doc.xpath("/").text
    end

    def get_xml_content(nsxml)
      parser = nsxml
      parser.delegate = XMLParse::XMLParserDelegate.new
      parser.parse
      parser.delegate.get_content_hash
    end


    def detect(text)
      # begin
      #   response = RestClient.get(
      #     "http://api.microsofttranslator.com/V2/Http.svc/Detect",
      #     detect_params(text)
      #   )
      #   parse_xml(response.body)
      # rescue RestClient::BadRequest
      #   false
      # end
    end

    #Set the private methods
    private

    def set_client(base_url, response = :http)

      access_token = "Bearer " + @auth.token

      client = AFMotion::SessionClient.build(base_url) do |client|
        client.session_configuration :default
        # client.header "Content-Type", "application/json"
        # client.header "Accept", "application/json"
        client.header "Authorization", access_token
        client.response_serializer response
      end

      return client
    end



    def translate_params(text, from_lang, to_lang, content_type)
      hash = base_params
      hash.store(:params,{
        "text" => text,
        "from" => from_lang,
        "to" => to_lang,
        "contentType" => content_type
      })
      hash
    end

    def detect_params(text)
      hash = base_params
      hash.store(:params,{
        "text" => text
      })
      hash
    end

  end






















  # Token service Azure Authentication
  class AzureAuthentication

    AUTH_URL = "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13"
    API_SCOPE = "http://api.microsofttranslator.com"
    GRANT_TYPE = "client_credentials"

    attr_reader :token, :token_expires_at

    def initialize

      set_authentication_params

      renew_token do |result|
        App::Persistence['mttkn'] = result
      end

      cash_request = App::Persistence['mttkn']
      if cash_request
        @token = cash_request['access_token']
        @token_expires_at = Time.now + cash_request['expires_in'].to_i
      end

    end

    def current_token
      if @token_expires_at
        if @token_expires_at < Time.now
          renew_token
        end
        @token
      end
    end


    def renew_token(&block)

      AFMotion::HTTP.post(AUTH_URL, auth_params) do |result|

        if result.success?
          json = BW::JSON.parse(result.body)
          block.call(json)
        else
          App.alert("Something wrong with the access token")
        end
      end
      #native_client
      #@semaphore = Dispatch::Semaphore.new(0)
      #@semaphore.signal
      #@semaphore.wait

    end


    private

    def set_authentication_params
      @client_id = "122d909f-2bfd-447d-8cec-78b76a053e9e" # Required. The client ID that you specified when you registered your application with Azure DataMarket.
      @client_secret = "gP1E7x1ikJkdJ823iaBvmSDLH46pvKXAEsRCE8WXnvo=" #Required. The client secret value that you obtained when you registered your application with Azure DataMarket.
    end

    def auth_params
      {
        client_id: @client_id,
        grant_type: GRANT_TYPE,
        scope: API_SCOPE,
        client_secret: @client_secret
      }
    end

  end

end
