require "felomvc/version"
require "felomvc/controller.rb"
require "felomvc/utils.rb"
require "felomvc/dependencies.rb"
require "felomvc/routing.rb"

module Felomvc
  class Application
    def call(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [ 500, { }, [] ]
      end
      get_rack_app(env).call(env)
    end

  end
end
