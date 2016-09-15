#Gem to manage erb files and render options in a template
require 'erubis'

module Felomvc
  class Controller
    #Method to read the template name following the conventions and then render it.
    def render(view_name, locals = {})
      #Goes to the directory and find the template name
      filename = File.join('app', 'views', controller_name, "#{view_name}.erb")
      #Read the template
      template = File.read(filename)
      #Pass the template to the Eruby gem to be rendered
      Erubis::Eruby.new(template).result(locals)
    end

    def controller_name
      #Sustract the word controller and convert it to snake case
      #Example MyPagescontroller => my_pages, with is the name of the container folder
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end
  end
end