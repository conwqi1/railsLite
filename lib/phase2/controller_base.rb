module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req = req
      @res = res
      @already_built_response = false
      
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response
    end

    # Set the response status code and header
    
    # Client request:
    #
    # GET /index.html HTTP/1.1
    # Host: www.example.com
    # Server response:
    #
    # HTTP/1.1 302 Found
    # Location: http://www.iana.org/domains/example/
    
    def redirect_to(url)
      raise "double render" if already_built_response?
      res.status = 302 
      res["Location"] = url
      @already_built_response = true
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, type)
      raise "double render" if already_built_response?
      res.body = content
      res.content_type = type
      @already_built_response = true
    end
  end
end


  