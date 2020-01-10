module Services
  class MemberJudgeService

    def initialize(member_candidates, judged_candidates_results)
      @member_candidates = member_candidates
      @judged_candidates_results = judged_candidates_results
    end

    def judge

      # バリデーション
      # リスト必須チェック


      if @member_candidates.blank?
        judged_result = {"error_message": "隊員候補リストは1つ以上の隊員を含んでください。"}
        @judged_candidates_results.push(judged_result)

      elsif @member_candidates.each do |member|
        member_name              = member[:member_name]
        event_planning           = member[:event_planning]
        cogitation               = member[:cogitation]
        coordination             = member[:coordination]
        programming_ability      = member[:programming_ability]
        infrastructure_knowledge = member[:infrastructure_knowledge]
        skill_sum = event_planning + cogitation + coordination + programming_ability + infrastructure_knowledge

        # バリデーション
        # パラメータ必須チェック

        if member_name == ""
          judged_result = {"member_name": nil, "error_message": "隊員名を設定してください。"}
        elsif event_planning == nil
          judged_result = {"member_name": member_name, "error_message": "イベント企画力を設定してください。"}
        elsif cogitation == nil
          judged_result = {"member_name": member_name, "error_message": "思考力を設定してください。"}
        elsif coordination == nil
          judged_result = {"member_name": member_name, "error_message": "調整力を設定してください。"}
        elsif programming_ability == nil
          judged_result = {"member_name": member_name, "error_message": "プログラム製造力を設定してください。"}
        elsif infrastructure_knowledge == nil
          judged_result = {"member_name": member_name, "error_message": "基盤理解を設定してください。"}

          # パラメータ形式チェック

        elsif member_name == "#{member_name.to_i}"
          judged_result = {"member_name": nil, "error_message": "隊員名は文字列で入力してください。"}
        elsif event_planning < 1 || 5 < event_planning
          judged_result = {"member_name": member_name, "error_message": "イベント企画力は1から5までの数値を設定してください。"}
        elsif cogitation < 1 || 5 < cogitation
          judged_result = {"member_name": member_name, "error_message": "思考力は1から5までの数値を設定してください。"}
        elsif coordination < 1 || 5 < coordination
          judged_result = {"member_name": member_name, "error_message": "調整力は1から5までの数値を設定してください。"}
        elsif programming_ability < 1 || 5 < programming_ability
          judged_result = {"member_name": member_name, "error_message": "プログラム製造力は1から5までの数値を設定してください。"}
        elsif infrastructure_knowledge < 1 || 5 < infrastructure_knowledge
          judged_result = {"member_name": member_name, "error_message": "基盤理解は1から5までの数値を設定してください。"}

          # 本処理

        elsif event_planning <= 1 || cogitation <= 1 || coordination <= 1 || programming_ability <= 1 || infrastructure_knowledge <= 1 || skill_sum <= 10
          judged_result = {"member_name": member_name, "enlisted_propriety": false}
        else
          judged_result = {"member_name": member_name, "enlisted_propriety": true}
        end

        @judged_candidates_results.push(judged_result)

        end
      end
    end
  end
end
