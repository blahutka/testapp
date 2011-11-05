# -*- encoding : utf-8 -*-
module ApplicationHelper

  # type = :warning or :alert cappuccino
  #        :error red
  #        :success green
  #        :info  blue

  def message(type, msg='', options= {:title => nil, :block => false, :close => true}, &block)
    block_message = 'block-message' if options[:block].present?
    #content_tag :section do
    content_tag :div, :class => ['alert-message', block_message, 'fade', 'in', type.to_s, options[:class]].join(' '), 'data-alert' => 'alert' do
      concat(link_to('&times;'.html_safe, '#', :class => 'close')) if options[:close]
      #concat(content_tag(:strong, options[:title])) if options[:title].present?
      #concat(content_tag(:p, ( (yield(block) if block_given?)  || (content_tag(:strong, options[:title]) + ' '+msg))))
      if block_given?
        content_tag(:p, block.try(:call))
      else
        concat content_tag(:strong, options[:title]) + ' '+msg
      end

    end if msg.presence || block.presence
    #end
  end

end
