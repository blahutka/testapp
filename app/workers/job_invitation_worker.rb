# -*- encoding : utf-8 -*-
class JobInvitationWorker
  LOGGER_FILE = File.open(File.join(Rails.root, 'log/match.log'), 'w')
  LOGGER_FILE.sync = true

  def self.logger
    @logger ||= Logger.new(LOGGER_FILE)
  end

  @queue = :job_invitation

  def self.perform(skill_request_id = nil)
    request = SkillRequest.find(skill_request_id)
    matched_profile = AccountProfile.first
    invitation = request.job_invitations.build
    invitation.to_profile_id = matched_profile.id
    invitation.save
    puts "Matching request: #{request.title} to: #{matched_profile.name}"
  end

end
