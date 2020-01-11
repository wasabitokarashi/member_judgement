module Services
  class MemberJudgeService

    attr_reader :judged_candidates_results

    def initialize(member_candidates)
      @member_candidates = member_candidates
      @judged_candidates_results = []
    end

    def execute
      begin
        member_candidates_present!(@member_candidates)
      rescue => e
        return {error_message: e.message}
      end

      @member_candidates.each do |member|
        @member_name              = member[:member_name]
        @event_planning           = member[:event_planning]
        @cogitation               = member[:cogitation]
        @coordination             = member[:coordination]
        @programming_ability      = member[:programming_ability]
        @infrastructure_knowledge = member[:infrastructure_knowledge]

        if parameter_require_check.present?
          @judged_candidates_results.push(parameter_require_check)
        elsif parameter_format_check.present?
          @judged_candidates_results.push(parameter_format_check)
        else
          @judged_candidates_results.push(judge)
        end
      end

      @judged_candidates_results
    end

    private

    # リスト必須チェック
    def member_candidates_present!(member_candidates)
      unless member_candidates.present?
        raise "隊員候補リストは1つ以上の隊員を含んでください。"
      end
    end

    # パラメータ必須チェック
    def parameter_require_check
      if @member_name == ""
        {"member_name": nil, "error_message": "隊員名を設定してください。"}
      elsif @event_planning == nil
        {"member_name": @member_name, "error_message": "イベント企画力を設定してください。"}
      elsif @cogitation == nil
        {"member_name": @member_name, "error_message": "思考力を設定してください。"}
      elsif @coordination == nil
        {"member_name": @member_name, "error_message": "調整力を設定してください。"}
      elsif @programming_ability == nil
        {"member_name": @member_name, "error_message": "プログラム製造力を設定してください。"}
      elsif @infrastructure_knowledge == nil
        {"member_name": @member_name, "error_message": "基本理解を設定してください。"}
      end
    end

    # パラメータ形式チェック
    def parameter_format_check
      if @member_name == "#{@member_name.to_i}"
        {"member_name": nil, "error_message": "隊員名は文字列で入力してください。"}
      elsif @event_planning < 1 || 5 < @event_planning
        {"member_name": @member_name, "error_message": "イベント企画力は1から5までの数値を設定してください。"}
      elsif @cogitation < 1 || 5 < @cogitation
        {"member_name": @member_name, "error_message": "思考力は1から5までの数値を設定してください。"}
      elsif @coordination < 1 || 5 < @coordination
        {"member_name": @member_name, "error_message": "調整力は1から5までの数値を設定してください。"}
      elsif @programming_ability < 1 || 5 < @programming_ability
        {"member_name": @member_name, "error_message": "プログラム製造力は1から5までの数値を設定してください。"}
      elsif @infrastructure_knowledge < 1 || 5 < @infrastructure_knowledge
        {"member_name": @member_name, "error_message": "基盤理解は1から5までの数値を設定してください。"}
      end
    end

    # 本処理
    def judge
      skill_sum = @event_planning + @cogitation + @coordination + @programming_ability + @infrastructure_knowledge

        if @event_planning <= 1 || @cogitation <= 1 || @coordination <= 1 || @programming_ability <= 1 || @infrastructure_knowledge <= 1 || skill_sum <= 10
          {"member_name": @member_name, "enlisted_propriety": false}
        else
          {"member_name": @member_name, "enlisted_propriety": true}
        end
    end
  end
end
