module API
  class EndpointJudgement < Grape::API
    mount Judgement::V1::Root
    mount Judgement::NoRoute
  end
end