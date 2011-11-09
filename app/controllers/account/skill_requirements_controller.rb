class Account::SkillRequirementsController < SkillRequirementsController
  
  belongs_to :skill_request, :optional => true
end
