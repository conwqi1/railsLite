require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'


module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    
    # #....
    # x = 5
    # #....
    # hi, <%= x %>; 
    # hi, 5; from t.result(biding)
    
    def render(template_name)
      t=ERB.new(File.read("views/#{self.class.to_s.underscore}/#{template_name}.html.erb"))
      content = t.result(binding)
      render_content(content, "text/html")
    end
    
    
  end
end
