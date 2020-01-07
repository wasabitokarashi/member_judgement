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

        post '/' do
          member_candidates = params[:member_candidates]
          def ListResults
            judeged_candidates_results = []
          end


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
            {"member_name": nil,
             "error_message": "隊員名を設定してください。"
            }
          elsif
            event_planning == nil
            {"member_name": member_name,
             "error_message": "イベント企画力を設定してください。"
            }
          elsif
            cogitation == nil
            {"member_name": member_name,
             "error_message": "思考力を設定してください。"
            }
          elsif
            coordination == nil
            {"member_name": member_name,
             "error_message": "調整力を設定してください。"
            }
          elsif
            programming_ability == nil
            {"member_name": member_name,
             "error_message": "プログラム製造力を設定してください。"
            }
          elsif
            infrastructure_knowledge == nil
            {"member_name": member_name,
             "error_message": "基盤理解を設定してください。"
            }

            # パラメータ形式チェック
          elsif
            member_name == "#{member_name.to_i}"
            {"member_name": nil,
             "error_message": "隊員名は文字列で入力してください。"
            }
          elsif
            event_planning < 1 || 5 < event_planning
            {"member_name": member_name,
             "error_message": "イベント企画力は1から5までの数値を設定してください。	"
            }
          elsif
            cogitation < 1 || 5 < cogitation
            {"member_name": member_name,
             "error_message": "思考力は1から5までの数値を設定してください。"
            }
          elsif
            coordination < 1 || 5 < coordination
            {"member_name": member_name,
             "error_message": "調整力は1から5までの数値を設定してください。"
            }
          elsif
            programming_ability < 1 || 5 < programming_ability
            {"member_name": member_name,
             "error_message": "プログラム製造力は1から5までの数値を設定してください。"
            }
          elsif
            infrastructure_knowledge < 1 || 5 < infrastructure_knowledge
            {"member_name": member_name,
             "error_message": "基盤理解は1から5までの数値を設定してください。																	"
            }

          # 本処理
          elsif
          event_planning <= 1 || cogitation <= 1 || coordination <= 1 || event_planning + cogitation + coordination + programming_ability + infrastructure_knowledge <= 10
            {"member_name": member_name,
             "enlisted_propriety": false
            }
          else
            {"member_name": member_name,
             "enlisted_propriety": true
            }


          end
          end

          # resource :judged_candidates_results do
          #   desc 'GET /api/v1/member_judge_entity'
          #   get '/' do
          #   end
          #   post '/' do
          #
          #   end
        end

      end
    end
  end
end
