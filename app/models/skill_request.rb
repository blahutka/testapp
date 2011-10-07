class SkillRequest < ActiveRecord::Base
  extend SimpleStateMachine::ActiveRecord

  STATUSES = :created, :approved, :invitation_opened, :invitation_closed,
      :terminated, :scheduled, :successful, :overtime

  field :account, :type => :references
  field :title, :type => :string
  field :state, :type => :string

  belongs_to :account

  has_many :job_invitations
  has_many :price_bids, :through => :job_invitations

  after_create :set_default_state


  
  event :set_default_state, nil => :created

  def approve
  end

  def open_invitations
    errors.add(:state, 'The request is not confirmed') unless self.approved?
  end

  def send_invitations
    (errors.add(:state, 'Cannot send invitations state: ' + self.state) and return false) unless self.approved? || self.invitation_opened?
     return self
  end

  def terminate;
  end

  event :approve, :created => :approved
  event :send_invitations,
        :approved => :invitation_opened,
        :invitation_opened => :invitation_opened
  event :open_invitations, :approved => :invitation_opened
  event :terminate,
        :approved => :terminated,
        :invitation_opened => :terminated,
        :invitation_closed => :terminated,
        :scheduled => :terminated
  event :schedule,
        :invitation_opened => :scheduled,
        :invitation_closed => :scheduled


end

SkillRequest.auto_upgrade!
