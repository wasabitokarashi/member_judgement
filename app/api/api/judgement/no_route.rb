module API
  module Judgement
    class NoRoute < Grape::API
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end
    end
  end
end