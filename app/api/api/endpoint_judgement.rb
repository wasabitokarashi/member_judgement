module API
  class EndpointJudgement < Grape::API
    mount JUDGEMENT::V1::Root
    mount JUDGEMENT::NoRoute
  end
end