module API
  module Judgement
    module V1
      class Root < Grape::API
        mount V1::MemberJudgeAPI
      end
    end
  end
end
