# -*- encoding : utf-8 -*-
module ApplicationHelper

  # type = :warning or :alert cappuccino
  #        :error red
  #        :success green
  #        :info  blue

  def message(type, msg='', options= {:title => nil, :block => false}, &block)
    block_message = 'block-message' if options[:block].present?

    content_tag :div, :class => ['alert-message', block_message, 'fade', 'in', type.to_s].join(' '), 'data-alert' => 'alert' do
      concat(link_to('&times;'.html_safe, '#', :class => 'close'))
      concat(content_tag(:strong, options[:title])) if options[:title].present? && block.presence
      concat(content_tag(:p, (block.try(:call) || (content_tag(:strong, options[:title]) + ' '+msg))))
    end if msg.presence || block.presence
  end

end
