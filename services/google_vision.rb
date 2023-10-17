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

    uri = URI.parse("https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDJldBAoY9XqVcRrRbww0tHyX8LrBZ9AXg")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == "https"
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = json_request.to_json
    request["Content-Type"] = "application/json"
    response = http.request(request)

    if response.code == "200"
      response_data = JSON.parse(response.body)['responses'][0]
      if response_data && response_data.key?('fullTextAnnotation')
        text = response_data['fullTextAnnotation']['text']

        # Log the extracted text
        puts "Extracted Text: #{text}"

        text
      else
        puts "No text found in the image."
        nil
      end
    else
      puts "Error response from API: #{response.body}"
      nil
    end
  end
end
