module API
  class EndpointJudgement < Grape::API
    mount JUDGEMENT::V1::Root
    mount JUDGEMENT::No_route
  end
end