# -*- encoding : utf-8 -*-
class SkillRequest < ActiveRecord::Base
  extend SimpleStateMachine::ActiveRecord

  STATUSES = :created, :approved, :opened, :closed,
      :canceled, :scheduled, :successful, :overtime, :matched, :completed


  field :account, :type => :references
  field :title, :type => :string
  field :state, :type => :string

  belongs_to :account

  has_many :job_invitations
  has_many :price_bids, :through => :job_invitations

  after_create :set_default_state
  after_commit :open, :if => lambda { |r| r.approved? }
  after_commit :send_invitations, :if => lambda { |r| r.opened? }
  after_commit :remove_from_queue, :if => lambda { |r| r.canceled? }


  def send_invitations
    puts 'start invitation'
    if (self.opened?)
      Resque.enqueue(JobInvitationWorker, self.id)
      puts 'added to resque'
    end
  end

 def open
 end

  def remove_from_queue
    logger.info("Remove from queue")
  end

  event :set_default_state, nil => :created

  event :approve, :created => :approved

  event :open,
        :approved => :opened,
        :opened => :opened,
        :canceled => :opened

  event :cancel,
        :approved => :canceled,
        :opened => :canceled,
        :closed => :canceled,
        :scheduled => :canceled

  event :schedule,
        :opened => :scheduled


  event :close,
        :opened => :closed,
        :canceled => :closed


end

SkillRequest.auto_upgrade!
