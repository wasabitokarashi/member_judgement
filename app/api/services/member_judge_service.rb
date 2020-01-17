module Services
  class MemberJudgeService

    attr_reader :judged_candidates_results

    def initialize(member_candidates)
      @member_candidates         = member_candidates
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

        begin
          parameter_require_check
        rescue => e
          @judged_candidates_results.push({member_name: @member_name, error_message: e.message})
          next
        end

        begin
          parameter_format_check
        rescue => e
          @judged_candidates_results.push({member_name: @member_name, error_message: e.message})
          next
        end

        @judged_candidates_results.push(judge)
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
      raise "隊員名を設定してください。"         if @member_name.blank?
      raise "イベント企画力を設定してください。"  if @event_planning.blank?
      raise "思考力を設定してください。"         if @cogitation.blank?
      raise "調整力を設定してください。"         if @coordination.blank?
      raise "プログラム製造力を設定してください。" if @programming_ability.blank?
      raise "基本理解を設定してください。"        if @infrastructure_knowledge.blank?
    end

    # パラメータ形式チェック
    def parameter_format_check
      raise "隊員名は文字列で入力してください。"                  unless @member_name !~ /\A[0-9]+\z/
      raise "イベント企画力は1から5までの数値を設定してください。"  if @event_planning < 1 || 5 < @event_planning
      raise "思考力は1から5までの数値を設定してください。"         if @cogitation < 1 || 5 < @cogitation
      raise "調整力は1から5までの数値を設定してください。"         if @coordination < 1 || 5 < @coordination
      raise "プログラム製造力は1から5までの数値を設定してください。" if @programming_ability < 1 || 5 < @programming_ability
      raise "基盤理解は1から5までの数値を設定してください。"        if @infrastructure_knowledge < 1 || 5 < @infrastructure_knowledge
    end

    # 本処理
    def judge
      skill_sum = @event_planning + @cogitation + @coordination + @programming_ability + @infrastructure_knowledge

      if @event_planning <= 1 || @cogitation <= 1 || @coordination <= 1 || skill_sum <= 10
        {"member_name": @member_name, "enlisted_propriety": false}
      else
        {"member_name": @member_name, "enlisted_propriety": true}
      end
    end
  end
end


###かずしに教えてもらったやり方(parameter_format_check)###
# ability_range_valid!(@event_planning, "イベント企画力は1から5までの数値を設定してください。")
# ability_range_valid!('', error_message)
# ability_range_valid!('ability', error_message)
# ability_range_valid!('ability', error_message)
# ability_range_valid!('ability', error_message)
# def ability_range_valid!(ability, error_message)
#   return {"member_name": @member_name, "error_message": "イベント企画力は1から5までの数値を設定してください。"} if @event_planning < 1 || 5 < @event_planning
# end