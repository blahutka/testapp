# -*- encoding : utf-8 -*-
class Tagging < ActiveRecord::Base
  field :tag,       :type => :references
  field :taggable,  :type => :references, :polymorphic => true
  field :tagger,    :type => :references, :polymorphic => true
  field :context,   :type => :string
  field :created_at, :type => :datetime

  add_index [:tag_id]
  add_index [:taggable_id, :taggable_type, :context]

  delegate :name, :to => :taggable

end

Tagging.auto_upgrade!
