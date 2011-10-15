# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  field :name, :type => :string
end

Tag.auto_upgrade!
