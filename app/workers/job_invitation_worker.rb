# -*- encoding : utf-8 -*-
class JobInvitationWorker

  @queue = :job_invitation

  def self.perform(skill_request_id = nil)
    skill_request = SkillRequest.find_by_id(skill_request_id)
    puts skill_request.title if skill_request
  end

end
