require "felomvc/version"

module Felomvc

  class Application
    def call(env)
      [200, {"Content-Type" => "text/html"}, ["Hello Felito from gem"]]
    end
  end

end
