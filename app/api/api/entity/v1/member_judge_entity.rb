module Entity
  module V1
    class MemberJudgeEntity < Grape::Entity
      # mount JUDGEMENT::V1::MemberJudgeAPI
      root 'judged_candidates_results'
    end
  end
end