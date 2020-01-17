# module Services
#   class SampleMemberJudgeService
#
#     attr_reader :judged_candidates_results
#
#     def initialize(member_candidates)
#       @member_candidates = member_candidates
#       # @error_message = nil
#       @judged_candidates_results = []
#     end
#
#     # バリデーション
#     def valid!
#
#       begin
#         candidates_present!(@member_candidates)
#
#
#
#
#       rescue => e
#         return {error_message: e.message }
#       end
#
#
#       return 'error だよ' if get_error(e).present?
#
#
#       return 'error' if e == 3
#
#       return 'error' if e == 4
#
#
#
#       y = get_tashizan_kekka + get_hikizan_kekka
#       s + y
#     end
#
#     # 本処理
#     def judge
#
#       @member_candidates
#     end
#
#     private
#
#     def candidates_present!(member_candidates)
#       if member_candidates.nil?
#         raise "隊員候補リストは1つ以上の隊員を含んでください。"
#       end
#     end
#
#
#     def get_error(e)
#       return 'error' if e == 2
#     end
#
#
#
#     def get_tashizan_kekka
#
#     end
#     def get_hikizan_kekka
#
#     end
#   end
# end
