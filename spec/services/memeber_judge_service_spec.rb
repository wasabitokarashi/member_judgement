# require_relative '../../app/api/services/new_member_judge_service'
#
# RSpec.describe Services::NewMemberJudgeService do
#
#   describe '未払い判定結果更新' do
#     describe '更新成功' do
#       context 'member_nameが空の場合' do
#         before do
#           candidates = nil
#           # candidates[:member_name] = nil
#           processor = Services::NewMemberJudgeService.new(candidates)
#           @response = processor.valid!
#           # @response = processor.judge
#         end
#         it '会員利用の未払判定フラグがつけられる' do
#           expect(@response).to eq('unchi')
#         end
#       end
#     end
#
#   end
# end