module API
  module Judgement
    module V1
      class Root < Grape::API
        prefix 'api' # /apiというパスになる
        version 'v1', using: :path # /api/v1というパスになる

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response e.to_json, 400
        end

        rescue_from :all do |e|
          if Rails.env.development?
            raise e
          else
            rack_response({ message: e.message, status: 500 }.to_json, 500)
          end
        end

        mount V1::MemberJudgeAPI
      end
    end
  end
end
