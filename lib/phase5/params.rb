require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    def initialize(req, route_params = {})
      @params = {}
      #route_params = {"id" => 5, "user_id" => 22}
      if route_params
        @params.merge!(route_params)
      end
      if req.query_string
        @params.merge!(parse_www_encoded_form(req.query_string))
      end
      if req.body
        @params.merge!(parse_www_encoded_form(req.body))
      end
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436   decode it
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)  
       key_hash = {}
       decoded_forms = URI::decode_www_form(www_encoded_form.to_s)
       decoded_forms.each do |key_arr, val|
         current_hash = key_hash
         parse_key(key_arr).each do |key|
           if key == parse_key(key_arr)[-1]
             current_hash[key] = val
           else
             current_hash[key] ||= {}
             current_hash = current_hash[key] 
           end
         end
       end
       key_hash
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
