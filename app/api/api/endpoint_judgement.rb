module API
  class EndpointJudgement < Grape::API
    mount Judgement::V1::Root
    mount Judgement::NoRoute
    route :any, '*path' do
      ## レスポンス
      error!({type: "notfound"}, 404)
    end
  end
end