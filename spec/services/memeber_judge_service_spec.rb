require_relative '../../app/api/services/member_judge_service'
require_relative '../rails_helper'

RSpec.describe Services::MemberJudgeService do

  describe 'ececute' do
    context '配列の要素が一つの時' do
      context 'バリデーション' do
        context 'member_candidatesが空の場合' do
          before do
            @member_candidates = nil
            processor = Services::MemberJudgeService.new(@member_candidates)
            @response = processor.execute
          end
          it '隊員候補リストは1つ以上入力してくださいのエラーメッセージ' do
            expect(@response).to eq ({error_message: "隊員候補リストは1つ以上の隊員を含んでください。"})
          end
        end

        context '各パラメータが空の場合' do
          context 'member_nameが空の場合' do
            before do
              processor = Services::MemberJudgeService.new([{
                                                               "member_name": "",
                                                               "event_planning": 3,
                                                               "cogitation": 3,
                                                               "coordination": 2,
                                                               "programming_ability": 2,
                                                               "infrastructure_knowledge": 1
                                                           }])
              @response = processor.execute
            end
            it '隊員名を設定してくださいのエラーメッセージ' do
              expect(@response).to eq ([{member_name: "", error_message: "隊員名を設定してください。"}])
            end
          end

          context 'event_planningが空の場合' do
            before do
              processor = Services::MemberJudgeService.new([{
                                                                "member_name": "doara",
                                                                "event_planning": "",
                                                                "cogitation": 3,
                                                                "coordination": 2,
                                                                "programming_ability": 2,
                                                                "infrastructure_knowledge": 1
                                                            }])
              @response = processor.execute
            end
            it '隊員名を設定してくださいのエラーメッセージ' do
              expect(@response).to eq ([{member_name: "doara", error_message: "イベント企画力を設定してください。"}])
            end
          end

          context 'cogitationが空の場合' do
            before do
              processor = Services::MemberJudgeService.new([{
                                                                "member_name": "doara",
                                                                "event_planning": 3,
                                                                "cogitation": "",
                                                                "coordination": 2,
                                                                "programming_ability": 2,
                                                                "infrastructure_knowledge": 1
                                                            }])
              @response = processor.execute
            end
            it '隊員名を設定してくださいのエラーメッセージ' do
              expect(@response).to eq ([{member_name: "doara", error_message: "思考力を設定してください。"}])
            end
          end

          context 'coordinationが空の場合' do
            before do
              processor = Services::MemberJudgeService.new([{
                                                                "member_name": "doara",
                                                                "event_planning": 3,
                                                                "cogitation": 3,
                                                                "coordination": "",
                                                                "programming_ability": 2,
                                                                "infrastructure_knowledge": 1
                                                            }])
              @response = processor.execute
            end
            it '隊員名を設定してくださいのエラーメッセージ' do
              expect(@response).to eq ([{member_name: "doara", error_message: "調整力を設定してください。"}])
            end
          end

          context 'programming_abilityが空の場合' do
            before do
              processor = Services::MemberJudgeService.new([{
                                                                "member_name": "doara",
                                                                "event_planning": 3,
                                                                "cogitation": 3,
                                                                "coordination": 2,
                                                                "programming_ability": "",
                                                                "infrastructure_knowledge": 1
                                                            }])
              @response = processor.execute
            end
            it '隊員名を設定してくださいのエラーメッセージ' do
              expect(@response).to eq ([{member_name: "doara", error_message: "プログラム製造力を設定してください。"}])
            end
          end

          context 'infrastructure_knowledgeが空の場合' do
            before do
              processor = Services::MemberJudgeService.new([{
                                                                "member_name": "doara",
                                                                "event_planning": 3,
                                                                "cogitation": 3,
                                                                "coordination": 2,
                                                                "programming_ability": 2,
                                                                "infrastructure_knowledge": ""
                                                            }])
              @response = processor.execute
            end
            it '隊員名を設定してくださいのエラーメッセージ' do
              expect(@response).to eq ([{member_name: "doara", error_message: "基本理解を設定してください。"}])
            end
          end
        end

        context '各パラメータが規定の表記でない場合' do
        context 'member_nameが文字列じゃない場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "222",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it '隊員名は文字列で入力してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "222", error_message: "隊員名は文字列で入力してください。"}])
          end
        end

        context 'event_planningがoの場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 0,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it 'イベント企画力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "イベント企画力は1から5までの数値を設定してください。"}])
          end
        end

        context 'event_planningが6の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 6,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it 'イベント企画力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "イベント企画力は1から5までの数値を設定してください。"}])
          end
        end

        context 'cogitationが0の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 0,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it '思考力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "思考力は1から5までの数値を設定してください。"}])
          end
        end

        context 'cogitationが6の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 6,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it '思考力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "思考力は1から5までの数値を設定してください。"}])
          end
        end

        context 'coordinationが0の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 0,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it '調整力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "調整力は1から5までの数値を設定してください。"}])
          end
        end

        context 'coordinationが6の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 6,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it '調整力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "調整力は1から5までの数値を設定してください。"}])
          end
        end

        context 'programming_abilityが0の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 0,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it 'プログラム製造力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "プログラム製造力は1から5までの数値を設定してください。"}])
          end
        end

        context 'programming_abilityが6の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 6,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it 'プログラム製造力は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "プログラム製造力は1から5までの数値を設定してください。"}])
          end
        end

        context 'infrastructure_knowledgeがoの場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 0
                                                          }])
            @response = processor.execute
          end
          it '基盤理解は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "基盤理解は1から5までの数値を設定してください。"}])
          end
        end

        context 'infrastructure_knowledgeが6の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 6
                                                          }])
            @response = processor.execute
          end
          it '基盤理解は1から5までの数値を設定してくださいのエラーメッセージ' do
            expect(@response).to eq ([{member_name: "doara", error_message: "基盤理解は1から5までの数値を設定してください。"}])
          end
        end
      end
      end

      context '本処理' do
      context 'event_planningが1の場合' do
        before do
          processor = Services::MemberJudgeService.new([{
                                                            "member_name": "doara",
                                                            "event_planning": 1,
                                                            "cogitation": 3,
                                                            "coordination": 2,
                                                            "programming_ability": 2,
                                                            "infrastructure_knowledge": 2
                                                        }])
          @response = processor.execute
        end
        it 'falseを返却' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": false}])
        end
      end

      context 'event_planningが2の場合' do
        before do
          processor = Services::MemberJudgeService.new([{
                                                            "member_name": "doara",
                                                            "event_planning": 2,
                                                            "cogitation": 3,
                                                            "coordination": 2,
                                                            "programming_ability": 2,
                                                            "infrastructure_knowledge": 2
                                                        }])
          @response = processor.execute
        end
        it 'trueを返却' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": true}])
        end
      end

      context 'cogitationが1の場合' do
        before do
          processor = Services::MemberJudgeService.new([{
                                                            "member_name": "doara",
                                                            "event_planning": 3,
                                                            "cogitation": 1,
                                                            "coordination": 2,
                                                            "programming_ability": 2,
                                                            "infrastructure_knowledge": 2
                                                        }])
          @response = processor.execute
        end
        it 'falseを返却' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": false}])
        end
      end

      context 'cogitationが2の場合' do
        before do
          processor = Services::MemberJudgeService.new([{
                                                            "member_name": "doara",
                                                            "event_planning": 3,
                                                            "cogitation": 2,
                                                            "coordination": 2,
                                                            "programming_ability": 2,
                                                            "infrastructure_knowledge": 2
                                                        }])
          @response = processor.execute
        end
        it 'trueを返却' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": true}])
        end
      end


      context 'coordinationが1の場合' do
        before do
          processor = Services::MemberJudgeService.new([{
                                                            "member_name": "doara",
                                                            "event_planning": 3,
                                                            "cogitation": 3,
                                                            "coordination": 1,
                                                            "programming_ability": 2,
                                                            "infrastructure_knowledge": 2
                                                        }])
          @response = processor.execute
        end
        it 'falseを返却' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": false}])
        end
      end

      context 'coordinationが2の場合' do
        before do
          processor = Services::MemberJudgeService.new([{
                                                            "member_name": "doara",
                                                            "event_planning": 3,
                                                            "cogitation": 3,
                                                            "coordination": 2,
                                                            "programming_ability": 2,
                                                            "infrastructure_knowledge": 2
                                                        }])
          @response = processor.execute
        end
        it 'trueを返却' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": true}])
        end
      end


      context 'スキル値の合計が10の場合' do
        before do
          processor = Services::MemberJudgeService.new([{
                                                            "member_name": "doara",
                                                            "event_planning": 3,
                                                            "cogitation": 3,
                                                            "coordination": 2,
                                                            "programming_ability": 1,
                                                            "infrastructure_knowledge": 1
                                                        }])
          @response = processor.execute
        end
        it 'falseを返却' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": false}])
        end
      end

      context 'スキル値の合計が11の場合' do
          before do
            processor = Services::MemberJudgeService.new([{
                                                              "member_name": "doara",
                                                              "event_planning": 3,
                                                              "cogitation": 3,
                                                              "coordination": 2,
                                                              "programming_ability": 2,
                                                              "infrastructure_knowledge": 1
                                                          }])
            @response = processor.execute
          end
          it ' trueを返却' do
            expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": true}])
          end
      end

      end

    end

    context '配列の要素が複数の時' do
      context 'どの要素もバリデーションにかかる場合' do
        before do
          processor = Services::MemberJudgeService.new([
                                                           {
                                                               "member_name": "",
                                                               "event_planning": 3,
                                                               "cogitation": 3,
                                                               "coordination": 2,
                                                               "programming_ability": 1,
                                                               "infrastructure_knowledge": 1
                                                           },
                                                           {
                                                               "member_name": "yoshiko",
                                                               "event_planning": "",
                                                               "cogitation": 5,
                                                               "coordination": 3,
                                                               "programming_ability": 2,
                                                               "infrastructure_knowledge": 2
                                                           }
                                                                        ]
                                                      )
          @response = processor.execute
        end
        it '各要素に対するエラーメッセージを要素とした配列を返す' do
          expect(@response).to eq ([{"member_name": "", "error_message": "隊員名を設定してください。"},{"member_name": "yoshiko", "error_message": "イベント企画力を設定してください。"}])
        end
      end

      context 'バリデーションにかかる要素と本処理される要素が混在している場合' do
        before do
          processor = Services::MemberJudgeService.new([
                                                           {
                                                               "member_name": "",
                                                               "event_planning": 3,
                                                               "cogitation": 3,
                                                               "coordination": 2,
                                                               "programming_ability": 1,
                                                               "infrastructure_knowledge": 1
                                                           },
                                                           {
                                                               "member_name": "yoshiko",
                                                               "event_planning": 3,
                                                               "cogitation": 5,
                                                               "coordination": 3,
                                                               "programming_ability": 2,
                                                               "infrastructure_knowledge": 2
                                                           }
                                                       ]
          )
          @response = processor.execute
        end
        it '各要素に対するエラーメッセージを要素とした配列を返す' do
          expect(@response).to eq ([{"member_name": "", "error_message": "隊員名を設定してください。"},{"member_name": "yoshiko", "enlisted_propriety": true}])
        end
      end

      context 'どの要素も本処理判定される場合' do
        before do
          processor = Services::MemberJudgeService.new([
                                                           {
                                                               "member_name": "doara",
                                                               "event_planning": 3,
                                                               "cogitation": 3,
                                                               "coordination": 2,
                                                               "programming_ability": 1,
                                                               "infrastructure_knowledge": 1
                                                           },
                                                           {
                                                               "member_name": "yoshiko",
                                                               "event_planning": 3,
                                                               "cogitation": 5,
                                                               "coordination": 3,
                                                               "programming_ability": 2,
                                                               "infrastructure_knowledge": 2
                                                           }
                                                       ]
          )
          @response = processor.execute
        end
        it '各要素に対するエラーメッセージを要素とした配列を返す' do
          expect(@response).to eq ([{"member_name": "doara", "enlisted_propriety": false},{"member_name": "yoshiko", "enlisted_propriety": true}])
        end

      end
    end
  end
end