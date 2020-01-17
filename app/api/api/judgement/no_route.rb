module API
  module Judgement
    class NoRoute < Grape::API
      rescue_from Exception do |e|
        binding.pry
        rack_response({ message: e.message, status: 404 }.to_json, 404)
      end
    end
  end
end