class Endpoint_judgement < Grape::API
  mount Root::Endpoint_judgement
  mount No_route::Endpoint_judgement
end