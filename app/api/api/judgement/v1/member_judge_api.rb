module API
  module Judgement
    module V1
      class MemberJudgeAPI < Grape::API
        format :json
        default_format :json

        require './app/api/services/memeber_judge_service.rb'
        include Services

        # p MemberJudgeAPI.include?(Services::MemberJudgeService)

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
          judged_candidates_results = []
          judged_result = MemberJudgeAPI.new

          member_judge_service = Services::MemberJudgeService.new(member_candidates, judged_candidates_results, judged_result)
          member_judge_service.judge
          # if member_candidates.blank?
          #   judged_result = {"error_message": "隊員候補リストは1つ以上の隊員を含んでください。"}
          #   judged_candidates_results.push(judged_result)
          # elsif
          #
          #   member_candidates.each do |member|
          #     member_name              = member[:member_name]
          #     event_planning           = member[:event_planning]
          #     cogitation               = member[:cogitation]
          #     coordination             = member[:coordination]
          #     programming_ability      = member[:programming_ability]
          #     infrastructure_knowledge = member[:infrastructure_knowledge]
          #
          #     ###切り出してみたメソッドたち置き場###
          #
          #       # バリデーション
          #         #　パラメータ必須チェック
          #         # require_check(member)
          #
          #         # パラメータ形式チェック
          #         # data_check(member)
          #
          #       # 本処理
          #       # member_judge(member)
          #
          #     ###メソッド置き場終了###
          #
          #
          #
          #     # バリデーション
          #       # パラメータ必須チェック
          #
          #     if
          #       member_name == ""
          #       judged_result = {"member_name": nil, "error_message": "隊員名を設定してください。"}
          #     elsif
          #       event_planning == nil
          #       judged_result = {"member_name": member_name, "error_message": "イベント企画力を設定してください。"}
          #     elsif
          #       cogitation == nil
          #       judged_result = {"member_name": member_name, "error_message": "思考力を設定してください。"}
          #     elsif
          #       coordination == nil
          #       judged_result = {"member_name": member_name, "error_message": "調整力を設定してください。"}
          #     elsif
          #       programming_ability == nil
          #       judged_result = {"member_name": member_name, "error_message": "プログラム製造力を設定してください。"}
          #     elsif
          #       infrastructure_knowledge == nil
          #       judged_result = {"member_name": member_name, "error_message": "基盤理解を設定してください。"}
          #
          #       # パラメータ形式チェック
          #
          #     elsif
          #       member_name == "#{member_name.to_i}"
          #       judged_result = {"member_name": nil, "error_message": "隊員名は文字列で入力してください。"}
          #     elsif
          #       event_planning < 1 || 5 < event_planning
          #       judged_result = {"member_name": member_name, "error_message": "イベント企画力は1から5までの数値を設定してください。"}
          #     elsif
          #       cogitation < 1 || 5 < cogitation
          #       judged_result = {"member_name": member_name, "error_message": "思考力は1から5までの数値を設定してください。"}
          #     elsif
          #       coordination < 1 || 5 < coordination
          #       judged_result = {"member_name": member_name, "error_message": "調整力は1から5までの数値を設定してください。"}
          #     elsif
          #       programming_ability < 1 || 5 < programming_ability
          #       judged_result = {"member_name": member_name, "error_message": "プログラム製造力は1から5までの数値を設定してください。"}
          #     elsif
          #       infrastructure_knowledge < 1 || 5 < infrastructure_knowledge
          #       judged_result = {"member_name": member_name, "error_message": "基盤理解は1から5までの数値を設定してください。"}
          #
          #     # 本処理
          #
          #     elsif
          #       event_planning <= 1 || cogitation <= 1 || coordination <= 1 || event_planning + cogitation + coordination + programming_ability + infrastructure_knowledge <= 10
          #       judged_result = {"member_name": member_name, "enlisted_propriety": false}
          #     else
          #       judged_result = {"member_name": member_name, "enlisted_propriety": true}
          #     end
          #
          #     judged_candidates_results.push(judged_result)
          #
          #   end
          #
          #   {judged_candidates_results: judged_candidates_results}
          #
          #
          # end
        end
      end
    end
  end
end
