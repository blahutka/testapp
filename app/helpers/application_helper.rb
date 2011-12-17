# -*- encoding : utf-8 -*-
module ApplicationHelper

  def test_me
    controller
  end

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



  #def modal_window(id, &block)
  #  content_for :me do
  #    content_tag :div, :id =>id, :class => '' do
  #
  #      content_tag :div, :class => 'modal-header' do
  #        link_to '&times;', '#', :class => 'close'
  #        content_tag :h3, 'Header'
  #      end
  #      content_tag :div, :class => 'modal-body' do
  #        yield
  #      end
  #
  #      content_tag :div, :class => 'modal-footer' do
  #        # buttons
  #      end
  #    end
  #  end
  #  return content_for :me
  #end

  #include Erector::Mixin
  class ModalBox < Erector::Widget
    needs :id

    def initialize(*args)
      super
      @buttons = nil
      @body = nil

      yield self if block_given?
    end

    def buttons(&block)
      @buttons = block
    end

    def body(&block)
      @body = block
    end

    def content
      div :id => @id, :class => 'modal hide fade', :style => 'position:absolute; width:700px;' do
        div :class => 'modal-header' do
          link_to 'x', '#', :class => 'close'
          h3 'Header'
        end
        div :class => 'modal-body' do
          div :class => 'wrap' do
            @body.call if @body
          end
        end

        div :class => 'modal-footer' do
          link_to 'Continue', root_path, :class => 'btn primary'
          @buttons.call if @buttons
        end
      end
    end


  end

  def modal_window(options = {}, &block)
    ApplicationHelper::ModalBox.new(:id => options[:id], &block).to_html
  end


end
