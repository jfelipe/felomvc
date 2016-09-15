require "felomvc/version"
require "felomvc/controller.rb"
require "felomvc/utils.rb"

module Felomvc

  class Application

    #This call will be 'called' every time a new instance of Application is created
    def call(env)

      #Root path

      if env["PATH_INFO"] == "/"
        return [302, {"Location" => "pages/about"}, []]
      end

      #Respong 500 to the favicon request

      if env["PATH_INFO"] == "/favicon.ico"
        return [500, {}, []]
      end

      # env["PATH_INFO"] = "/pages/about" => PagesController.send(:about)
      controller_class, action = get_controller_and_action(env)

      #with the controller name and the action, this line sends the action to the controller name
      response = controller_class.new.send(action)

      [200, {"Content-Type" => "text/html"}, [response]]
    end

    def get_controller_and_action(env)
      #From path info it grabs the information of the controller name and the action to be send
      _, controller_name, action = env["PATH_INFO"].split("/")

      #Grabs the controller name from the route, convert it to camel case and adds the controller word to follow the conventions
      #Example route /my_pages/about => MyPagesController
      controller_name = controller_name.to_camel_case + "Controller"

      #Returns an array with the controller name constantized and the action
      #This change is made because it is no possible to create instances of strings.
      [ Object.const_get(controller_name), action ]
    end

  end

end
