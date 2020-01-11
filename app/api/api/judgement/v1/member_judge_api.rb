module API
  module Judgement
    module V1
      class MemberJudgeAPI < Grape::API
        format :json
        default_format :json

        include Services

        # helpers do
        #   def require_check(member)
        #     member.each do |key, value|
        #       if value.blank?
        #         {"member_name": member[:member_name], "error_message": "#{key}を設定してください。"}
        #       else
        #         break
        #       end
        #     end
        #   end
        #
        # def require_check(member)
        #   member.each do |key, value|
        #     if value == ""
        #       judged_result = {"member_name": nil, "error_message": "隊員名を設定してください。"}
        #       break
        #     elsif value == nil
        #       judged_result = {"member_name": member[:member_name], "error_message": "#{key}を設定してください。"}
        #       break
        #     else
        #       break
        #     end
        #   end
        # end
        #
        #   def data_check(member)
        #     member.each do |key, value|
        #       if value == "#{member[:member_name].to_i}"
        #         judged_result = {"member_name": nil, "error_message": "隊員名は文字列で入力してください。"}
        #         break
        #       elsif value.to_i < 1 || 5 < value.to_i
        #         judged_result = {"member_name": member[:member_name], "error_message": "#{key}は1から5までの数値を設定してください。"}
        #         break
        #       else
        #         break
        #       end
        #     end
        #   end
        #
        #   def member_judge(member)
        #     skills_sum = member[:event_planning] + member[:cogitation] + member[:coordination] + member[:programming_ability] + member[:infrastructure_knowledge]
        #
        #       if skills_sum <= 10
        #         judged_result = {"member_name": member[:member_name], "enlisted_propriety": false}
        #       else
        #         judged_result = {"member_name": member[:member_name], "enlisted_propriety": true}
        #       end
        #   end
        # end

        params do
          optional :member_candidates, type: Array do
            optional :member_name,              type: String
            optional :event_planning,           type: Integer
            optional :cogitation,               type: Integer
            optional :coordination,             type: Integer
            optional :programming_ability,      type: Integer
            optional :infrastructure_knowledge, type: Integer
          end
        end
        post '/' do
          member_candidates = params[:member_candidates]

          member_judge_service = Services::MemberJudgeService.new(member_candidates)
          {judged_candidates_results: member_judge_service.execute}
        end
      end
    end
  end
end
