#Gem to manage erb files and render options in a template
require 'erubis'

module Felomvc
  class Controller

    attr_reader :request

    #Initialize to find if request is sent or just the simple call to action
    def initialize(env)
      @request ||= Rack::Request.new(env)
    end

    #Access to params
    def params
      request.params
    end

    def response(body, status=200, header={})
      @response = Rack::Response.new(body, status, header)
    end

    def get_response
      @response
    end

    def render(*args)
      response(render_template(*args))
    end
    #Method to read the template name following the conventions and then render it.
    def render_template(view_name, locals = {})
      #Goes to the directory and find the template name
      filename = File.join('app', 'views', controller_name, "#{view_name}.erb")
      #Read the template
      template = File.read(filename)

      # {name: "Felipe"}
      vars = {}
      instance_variables.each do |var|
        key = var.to_s.gsub("@", "").to_sym
        vars[key] = instance_variable_get(var)
      end
      #Pass the template to the Eruby gem to be rendered
      Erubis::Eruby.new(template).result(locals.merge(vars))
    end

    def controller_name
      #Sustract the word controller and convert it to snake case
      #Example MyPagescontroller => my_pages, with is the name of the container folder
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end

    def dispatch(action)
      content = self.send(action)
      if get_response
        get_response
      else
        render(action)
        get_response
      end
    end

    def self.action(action_name)
      -> (env) {self.new(env).dispatch(action_name)}
    end

  end

end