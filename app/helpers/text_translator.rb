class TextTranslator

  def translate(text, from, to)

    from ||= "en";
    to ||= "pt";

    puts ">>>>>> #{text}"

    result = get_translation(text, from, to)

    puts "=====>>> #{result}"

  end


  def get_translation(text, from, to)

      client_id = "122d909f-2bfd-447d-8cec-78b76a053e9e" # Required. The client ID that you specified when you registered your application with Azure DataMarket.
      client_secret = "gP1E7x1ikJkdJ823iaBvmSDLH46pvKXAEsRCE8WXnvo=" #Required. The client secret value that you obtained when you registered your application with Azure DataMarket.
      scope = "http://api.microsofttranslator.com" #   Required. Use the URL http://api.microsofttranslator.com as the scope value for the Microsoft Translator API.
      grant_type = "client_credentials" #Required. Use "client_credentials" as the grant_type value for the Microsoft Translator API. 

      uri = "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13/"

      rmq.animations.start_spinner

      client = AFMotion::Client.build_shared(uri) do |client|

        client.request_serializer :json

        client.header "Accept", "application/json"
        client.response_serializer :json
      end

      client.post(uri, {client_id: client_id, client_secret: client_secret, scope: scope, grant_type: grant_type}) do |result|

        puts result.status_code
        if result.success?

          if token_result = result.object

              authToken = "Bearer #{token_result["access_token"]}"

              puts token_result

              uri = "https://api.microsofttranslator.com/v2/Http.svc/Translate?text=#{text}&from=#{from}&to=#{to}"
              #client = client_connection(uri)

             AFMotion::HTTP.get(uri, {:authorization => authToken}) do |result|

                  p result.status_code

                  if response = result.body

                    p result.body

                  end

              end

            rmq.animations.stop_spinner
          end

        elsif result.failure?
          # result.error is an NSError
          p result.error.localizedDescription
        end

      end

  end





  def client_connection(uri)

    client = AFMotion::SessionClient.build_shared(uri) do |client|

      client.header "Accept", "application/json"
      client.response_serializer :json

      # client.header "Accept", "application/http"
      # client.response_serializer :http
    end

    return client
  end

  def translation(authToken)

    uri = "http://api.microsofttranslator.com/"

    client = client_connection(uri)

    client.authorization(token: authToken)

    client.get("v2/Http.svc/Translate?text=#{text}&from=#{from}&to=#{to}") do |result|

        p result.operation.inspect
        p result.status_code

        if result.object

          # result.object depends on the type of operation.
          # For JSON and PLIST, this is usually a Hash.
          # For XML, this is an NSXMLParser
          # For HTTP, this is an NSURLResponse
          # For Image, this is a UIImage

          p result.object

        elsif result.failure?
          # result.error is an NSError
          p result.error.localizedDescription
        end

    end
  end

end