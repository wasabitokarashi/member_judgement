require_relative '../rails_helper'

RSpec.describe API::Judgement::V1::MemberJudgeAPI do
  context '正しいリクエストされた場合'do
    before do
      post '/api/v1/', params: {
                                    "member_candidates":
                                        [
                                            {
                                                "member_name": "doara",
                                                "event_planning": "3",
                                                "cogitation": "2",
                                                "coordination": "2",
                                                "programming_ability": "2",
                                                "infrastructure_knowledge": "2"
                                            }
                                        ]
                                }
    end
    it '201のコードを返す'do
      expect(response.status).to eq(201)
    end
  end

  context '不正なURLでリクエストされた場合'do
    before do
      post '/api/v', params: {
                                "member_candidates":
                                      [
                                          {
                                              "member_name": "doara",
                                              "event_planning": "3",
                                              "cogitation": "2",
                                              "coordination": "2",
                                              "programming_ability": "2",
                                              "infrastructure_knowledge": "2"
                                          }
                                      ]
                              }
    end
    it '404のエラーコードを返す'do
      expect(response.status).to eq(404)
    end
  end

  context '不正な形式でリクエストされた場合'do
    before do
      post '/api/v1/', params: "{"
    end
    it '400のエラーコードを返す'do
      expect(response.status).to eq(400)
    end
  end

  describe 'postアクションを実行' do
    before do
      @singular_params =
          {
              "member_candidates":
                  [
                      {
                          "member_name": "doara",
                          "event_planning": "2",
                          "cogitation": "2",
                          "coordination": "2",
                          "programming_ability": "2",
                          "infrastructure_knowledge": "3"
                      }
                  ]
          }
      @multiple_params =
          {
              "member_candidates":
                  [
                      {
                          "member_name": "doara",
                          "event_planning": "3",
                          "cogitation": "3",
                          "coordination": "2",
                          "programming_ability": "1",
                          "infrastructure_knowledge": "1"
                      },
                      {
                          "member_name": "yoshiko",
                          "event_planning": "3",
                          "cogitation": "5",
                          "coordination": "3",
                          "programming_ability": "2",
                          "infrastructure_knowledge": "2"
                      }
                  ]
          }
    end

    context '配列の要素が一つの時' do
      context 'validation' do
        context 'member_candidatesが空の場合' do
          before do
            @singular_params[:member_candidates] = nil
            post '/api/v1/', params: @singular_params
          end
          it '"隊員候補リストは1つ以上の隊員を含んでください。"のエラーメッセージを返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"]["error_message"]).to eq("隊員候補リストは1つ以上の隊員を含んでください。")
          end
        end

        context '各項目が空の場合' do
          context 'member_nameが空の場合' do
            before do
              @singular_params[:member_candidates][0][:member_name] = nil
              post '/api/v1/', params: @singular_params
            end
            it '"隊員名を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("隊員名を設定してください。")
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["member_name"]).to eq(nil)
            end
          end

          context 'event_planningが空の場合' do
            before do
              @singular_params[:member_candidates][0][:event_planning] = nil
              post '/api/v1/', params: @singular_params
            end
            it '"イベント企画力を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("イベント企画力を設定してください。")
            end
          end

          context 'cogitationが空の場合' do
            before do
              @singular_params[:member_candidates][0][:cogitation] = nil
              post '/api/v1/', params: @singular_params
            end
            it '"思考力を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("思考力を設定してください。")
            end
          end

          context 'coordinationが空の場合' do
            before do
              @singular_params[:member_candidates][0][:coordination] = nil
              post '/api/v1/', params: @singular_params
            end
            it '"調整力を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("調整力を設定してください。")
            end
          end

          context 'programming_abilityが空の場合' do
            before do
              @singular_params[:member_candidates][0][:programming_ability] = nil
              post '/api/v1/', params: @singular_params
            end
            it '"プログラム製造力を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("プログラム製造力を設定してください。")
            end
          end

          context 'infrastructure_knowledgeが空の場合' do
            before do
              @singular_params[:member_candidates][0][:infrastructure_knowledge] = nil
              post '/api/v1/', params: @singular_params
            end
            it '"基本理解を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("基本理解を設定してください。")
            end
          end
        end

        context '各項目が指定外の形式の場合' do
          context 'member_nameが文字列でない場合' do
            before do
              @singular_params[:member_candidates][0][:member_name] = "222"
              post '/api/v1/', params: @singular_params
            end
            it '"隊員名は文字列で入力してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("隊員名は文字列で入力してください。")
            end
          end

          context 'event_planningが0の場合' do
            before do
              @singular_params[:member_candidates][0][:event_planning] = "0"
              post '/api/v1/', params: @singular_params
            end
            it '"イベント企画力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("イベント企画力は1から5までの数値を設定してください。")
            end
          end

          context 'event_planningが6の場合' do
            before do
              @singular_params[:member_candidates][0][:event_planning] = "6"
              post '/api/v1/', params: @singular_params
            end
            it '"イベント企画力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("イベント企画力は1から5までの数値を設定してください。")
            end
          end

          context 'cogitationが0の場合' do
            before do
              @singular_params[:member_candidates][0][:cogitation] = "0"
              post '/api/v1/', params: @singular_params
            end
            it '"思考力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("思考力は1から5までの数値を設定してください。")
            end
          end

          context 'cogitationが6の場合' do
            before do
              @singular_params[:member_candidates][0][:cogitation] = "6"
              post '/api/v1/', params: @singular_params
            end
            it '"思考力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("思考力は1から5までの数値を設定してください。")
            end
          end

          context 'coordinationが0の場合' do
            before do
              @singular_params[:member_candidates][0][:coordination] = "0"
              post '/api/v1/', params: @singular_params
            end
            it '"調整力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("調整力は1から5までの数値を設定してください。")
            end
          end

          context 'coordinationが6の場合' do
            before do
              @singular_params[:member_candidates][0][:coordination] = "6"
              post '/api/v1/', params: @singular_params
            end
            it '"調整力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("調整力は1から5までの数値を設定してください。")
            end
          end

          context 'programming_abilityが0の場合' do
            before do
              @singular_params[:member_candidates][0][:programming_ability] = "0"
              post '/api/v1/', params: @singular_params
            end
            it '"調整力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("プログラム製造力は1から5までの数値を設定してください。")
            end
          end

          context 'programming_abilityが6の場合' do
            before do
              @singular_params[:member_candidates][0][:programming_ability] = "6"
              post '/api/v1/', params: @singular_params
            end
            it '"調整力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("プログラム製造力は1から5までの数値を設定してください。")
            end
          end

          context 'infrastructure_knowledgeが0の場合' do
            before do
              @singular_params[:member_candidates][0][:infrastructure_knowledge] = "0"
              post '/api/v1/', params: @singular_params
            end
            it '"調整力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("基盤理解は1から5までの数値を設定してください。")
            end
          end

          context 'infrastructure_knowledgeが6の場合' do
            before do
              @singular_params[:member_candidates][0][:infrastructure_knowledge] = "6"
              post '/api/v1/', params: @singular_params
            end
            it '"調整力は1から5までの数値を設定してください。"のエラーメッセージを返す' do
              expect(JSON.parse(response.body)["judged_candidates_results"][0]["error_message"]).to eq("基盤理解は1から5までの数値を設定してください。")
            end
          end
        end
      end

      context '本処理判定' do
        context 'event_planningが1の場合' do
          before do
            @singular_params[:member_candidates][0][:event_planning] = "1"
            post '/api/v1/', params: @singular_params
          end
          it 'falseの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(false)
          end
        end

        context 'event_planningが2の場合' do
          before do
            @singular_params[:member_candidates][0][:event_planning] = "2"
            post '/api/v1/', params: @singular_params
          end
          it 'trueの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(true)
          end
        end

        context 'cogitationが1の場合' do
          before do
            @singular_params[:member_candidates][0][:cogitation] = "1"
            post '/api/v1/', params: @singular_params
          end
          it 'falseの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(false)
          end
        end

        context 'cogitationが2の場合' do
          before do
            @singular_params[:member_candidates][0][:cogitation] = "2"
            post '/api/v1/', params: @singular_params
          end
          it 'trueの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(true)
          end
        end

        context 'coordinationが1の場合' do
          before do
            @singular_params[:member_candidates][0][:coordination] = "1"
            post '/api/v1/', params: @singular_params
          end
          it 'falseの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(false)
          end
        end

        context 'coordinationが2の場合' do
          before do
            @singular_params[:member_candidates][0][:coordination] = "2"
            post '/api/v1/', params: @singular_params
          end
          it 'trueの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(true)
          end
        end

        context 'スキルの合計値が10の場合' do
          before do
            @singular_params[:member_candidates][0][:infrastructure_knowledge] = "2"
            post '/api/v1/', params: @singular_params
          end
          it 'falseの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(false)
          end
        end

        context 'スキルの合計値が11の場合' do
          before do
            post '/api/v1/', params: @singular_params
          end
          it 'trueの判定結果を返す' do
            expect(JSON.parse(response.body)["judged_candidates_results"][0]["enlisted_propriety"]).to eq(true)
          end
        end
      end
    end

    context '配列の要素が複数の時' do
      context 'どの要素もバリデーションにかかる場合' do
        before do
          @multiple_params[:member_candidates][0][:member_name] = nil
          @multiple_params[:member_candidates][1][:event_planning] = nil
          post '/api/v1/', params: @multiple_params
          # p @multiple_params
        end
        it '各要素に対するエラーメッセージを要素とした配列を返す' do
          # p response.body
          expect(JSON.parse(response.body)["judged_candidates_results"]).to eq([{"member_name" => nil, "error_message" => "隊員名を設定してください。"},{"member_name" => "yoshiko", "error_message" => "イベント企画力を設定してください。"}])
        end
      end

      context 'バリデーションにかかる要素と本処理される要素が混在している場合' do
        before do
          @multiple_params[:member_candidates][0][:member_name] = nil
          post '/api/v1/', params: @multiple_params
        end
        it 'バリデーションと本処理それぞれに対するレスポンスを要素とした配列を返す' do
          expect(JSON.parse(response.body)["judged_candidates_results"]).to eq([{"member_name" => nil, "error_message" => "隊員名を設定してください。"},{"member_name" => "yoshiko", "enlisted_propriety" => true}])
        end
      end

      context 'どの要素も本処理判定される場合' do
        before do
          post '/api/v1/', params: @multiple_params
        end
        it '各要素に対する本処理結果を要素とした配列を返す' do
          expect(JSON.parse(response.body)["judged_candidates_results"]).to eq([{"member_name" => "doara", "enlisted_propriety" => false},{"member_name" => "yoshiko", "enlisted_propriety" => true}])
        end
      end
    end

  end
end