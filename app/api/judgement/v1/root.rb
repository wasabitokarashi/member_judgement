module API
  module JUDGEMENT
    module V1
      class Root < Grape::API
        mount V1::MemberJudgeApi
        mount V1::MessageDefinition
      end
    end
  end
end
