module API
  module Judgement
    module V1
      class Root < Grape::API
        prefix 'api' # /apiというパスになる
        version 'v1', using: :path # /api/v1というパスになる

        rescue_from ActiveRecord::RecordNotFound do |e|
          rack_response({ message: e.message, status: 404 }.to_json, 404)
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
