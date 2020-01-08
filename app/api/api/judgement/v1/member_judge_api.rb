module API
  module JUDGEMENT
    module V1
      class MemberJudgeAPI < Grape::API
        format :json
        default_format :json

        prefix 'api' # /apiというパスになる
        version 'v1', using: :path # /api/v1というパスになる

        rescue_from ActiveRecord::RecordNotFound do |e|
          rack_response({ message: e.message, status: 404 }.to_json, 404)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response e.to_json, 400
        end

        rescue_from :all do |e|
          if Rails.env.development?
            raise e
          else
            rack_response({ message: e.message, status: 500 }.to_json, 500)
          end
        end

        params do
          requires :member_candidates, type: Array do
            requires :member_name, type: String
            requires :event_planning, type: Integer
            requires :cogitation, type: Integer
            requires :coordination, type: Integer
            requires :programming_ability, type: Integer
            requires :infrastructure_knowledge, type: Integer
          end
        end



        # resource :judged_candidates_results do

          post '/' do
            member_candidates = params[:member_candidates]

            judged_candidates_results = []
            judged_result = MemberJudgeAPI.new

            member_candidates.each do |member|


            member_name =  member[:member_name]
            event_planning = member[:event_planning]
            cogitation = member[:cogitation]
            coordination = member[:coordination]
            programming_ability = member[:programming_ability]
            infrastructure_knowledge = member[:infrastructure_knowledge]

            # バリデーション
              # パラメータ必須チェック
            if
              member_name == ""
              judged_result = {"member_name": nil, "error_message": "隊員名を設定してください。"}
            elsif
              event_planning == nil
              judged_result = {"member_name": member_name, "error_message": "イベント企画力を設定してください。"}
            elsif
              cogitation == nil
              judged_result = {"member_name": member_name, "error_message": "思考力を設定してください。"}
            elsif
              coordination == nil
              judged_result = {"member_name": member_name, "error_message": "調整力を設定してください。"}
            elsif
              programming_ability == nil
              judged_result = {"member_name": member_name, "error_message": "プログラム製造力を設定してください。"}
            elsif
              infrastructure_knowledge == nil
              judged_result = {"member_name": member_name, "error_message": "基盤理解を設定してください。"}

              # パラメータ形式チェック
            elsif
              member_name == "#{member_name.to_i}"
              judged_result = {"member_name": nil, "error_message": "隊員名は文字列で入力してください。"}
            elsif
              event_planning < 1 || 5 < event_planning
              judged_result = {"member_name": member_name, "error_message": "イベント企画力は1から5までの数値を設定してください。	"}
            elsif
              cogitation < 1 || 5 < cogitation
              judged_result = {"member_name": member_name, "error_message": "思考力は1から5までの数値を設定してください。"}
            elsif
              coordination < 1 || 5 < coordination
              judged_result = {"member_name": member_name, "error_message": "調整力は1から5までの数値を設定してください。"}
            elsif
              programming_ability < 1 || 5 < programming_ability
              judged_result = {"member_name": member_name, "error_message": "プログラム製造力は1から5までの数値を設定してください。"}
            elsif
              infrastructure_knowledge < 1 || 5 < infrastructure_knowledge
              judged_result = {"member_name": member_name, "error_message": "基盤理解は1から5までの数値を設定してください。"}

            # 本処理
            elsif
              event_planning <= 1 || cogitation <= 1 || coordination <= 1 || event_planning + cogitation + coordination + programming_ability + infrastructure_knowledge <= 10
              judged_result = {"member_name": member_name, "enlisted_propriety": false}
            else
              judged_result = {"member_name": member_name, "enlisted_propriety": true}
            end

            judged_candidates_results.push(judged_result)

            end

            {"judged_candidates_results" => judged_candidates_results}

            # get '/' do
            # present judged_candidates_results, with: Entity::V1::MemberJudgeEntity
            # end

          end
        # end
      end
    end
  end
end
