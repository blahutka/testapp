# -*- encoding : utf-8 -*-
class SkillRequest < ActiveRecord::Base

  extend SimpleStateMachine::ActiveRecord

  INVITATION_SIZE = 4
  STATUSES = :created, :approved, :opened, :matched, :closed,
      :canceled, :scheduled, :successful, :overtime, :matched, :completed

  #acts_as_taggable
  #acts_as_taggable_on :skills

  field :account, :type => :references
  field :title, :type => :string
  field :state, :type => :string

  belongs_to :account

  has_one :skill_requirement
  accepts_nested_attributes_for :skill_requirement
  #delegate :when, :to => :skill_requirement

  has_many :job_invitations, :foreign_key => 'from_request_id',
           :after_remove => [:check_reopen_invitation, lambda { |r| raise 'noo' }]


  has_many :price_bids, :through => :job_invitations #, :source => :from, :class_name => 'PriceBid'


  after_create :set_default_state
  after_commit :open, :if => lambda { |r| r.approved? }
  after_commit :send_invitations, :if => lambda { |r| r.opened? }
  after_commit :remove_from_queue, :if => lambda { |r| r.canceled? }
  after_commit :check_max_invitation, :if => lambda { |r| r.matching? || r.opened? }

  #validate :must_be_approved_before_send
  #validates :title, :presence => true

  before_create :set_title
  def set_title
    self.title = 'Title?'
  end

  def must_be_approved_before_send
    errors[:state] << 'Cannot send invitations: not approved request' unless self.approved?
  end

  def check_max_invitation
    self.stop! if self.job_invitations.count >= 4
  end

  def check_reopen_invitation
    logger.info 'check reopen invitation'
    self.open! unless (self.job_invitations.reload.count >= 4 || self.canceled? || self.closed? || self.scheduled?)
  end

  def send_invitations
    #errors[:state] << 'Cannot send invitations: not approved request' and return false unless (self.opened? || self.approved?)
    Resque.enqueue(JobInvitationWorker, self.id)
    logger.info('Invitations send')
  end

  def open
  end

  def match
    self.send_invitations
  end

  def remove_from_queue
    logger.info("Remove from queue")
  end

  event :set_default_state, nil => :created

  event :approve, :created => :approved

  event :open,
        :approved => :opened,
        :canceled => :opened,
        :closed => :opened,
        :matched => :opened

  event :match,
        :opened => :matching,
        :matching => :matching

  event :stop,
        :matching => :matched,
        :opened => :matched

  event :cancel,
        :canceled => :canceled,
        :approved => :canceled,
        :opened => :canceled,
        :matched => :canceled,
        :matching => :canceled,
        :scheduled => :canceled

  event :schedule,
        :opened => :scheduled


  event :close,
        :opened => :closed,
        :canceled => :closed,
        :matched => :closed


  def invited?(model)
    self.job_invitations.include?(model)
  end

  def invite(profile)
    invitation = self.job_invitations.build
    invitation.to_profile_id = profile.id
    invitation.save!
  end
end

SkillRequest.auto_upgrade!
