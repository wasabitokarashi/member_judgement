require_relative '../../app/api/services/member_judge_service'
require_relative '../rails_helper'

RSpec.describe Services::MemberJudgeService do

  describe 'バリデーション' do
    describe 'member_candidatesが空の場合' do
      before do
        @member_candidates = nil
        processor = Services::MemberJudgeService.new(@member_candidates)
        @response = processor.execute
      end
      it '隊員候補リストは1つ以上入力してくださいのエラーメッセージ' do
        expect(@response).to eq ({error_message: "隊員候補リストは1つ以上の隊員を含んでください。"})
      end
        # before do
        #   candidates = nil
        #   # candidates[:member_name] = nil
        #   processor = Services::NewMemberJudgeService.new(candidates)
        #   @response = processor.valid!
        #   # @response = processor.judge
        # end
        # it '会員利用の未払判定フラグがつけられる' do
        #   expect(@response).to eq('unchi')
        # end
    end

  end
end