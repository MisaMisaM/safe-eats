require "base64"
require "json"
require "net/https"
require "google/cloud/vision"

class GoogleVisionService
  attr_reader :image_url

  def initialize(image_url)
    @image_url = image_url
  end

  def extract_text
    json_request = {
      "requests": [
        {
          "features": [
            {
              "type": "TEXT_DETECTION"
            }
          ],
          "image": {
            "source": {
              "imageUri": @image_url
            }
          }
        }
      ]
    }

    uri = URI.parse("https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDJldBAoY9XqVcRrRbww0tHyX8LrBZ9AXg")  # Replace with your actual API key
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = json_request.to_json
    request["Content-Type"] = "application/json"
    response = http.request(request)

    if response.code == "200"
      response_data = JSON.parse(response.body)
      # Debugging output
      puts "Google Vision response:"
      puts response_data.to_json

      if response_data.key?('responses') && response_data['responses'][0].key?('fullTextAnnotation')
        text = response_data['responses'][0]['fullTextAnnotation']['text']
        puts "Extracted Text: #{text}"
        text
      else
        puts "No text found in the image."
        nil
      end
    else
      puts "Error response from Google Vision API: #{response.body}"
      nil
    end
  end
end
