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

  def modal_window(id, &block)
    content_for :me do
      content_tag :div, :id =>id, :class => '' do

        content_tag :div, :class => 'modal-header' do
          link_to '&times;', '#', :class => 'close'
          content_tag :h3, 'Header'
        end
        content_tag :div, :class => 'modal-body' do
          yield
        end

        content_tag :div, :class => 'modal-footer' do
          # buttons
        end
      end
    end
    return content_for :me
  end

  #include Erector::Mixin
  class ModalBox < Erector::Widget
    needs :id

    def content
      div :id => @id, :class => 'modal hidex fade' do
        div :class => 'modal-header' do
          link_to 'x', '#', :class => 'close'
          h3 'Header'
        end
        div :class => 'modal-body' do
          super
        end

        div :class => 'modal-footer' do

        end
      end
    end

    def more(&block)
      yield
    end


  end

  def message2(is = nil, &block)

    if block_given?
      out = Erector.inline() do
        @block = capture(&block)
        widget ApplicationHelper::ModalBox, :id => 'my-modal' do
          text @block
        end
      end
      out.to_html
    end

  end

  def message3(&block)
    @block = capture(&block)
    ApplicationHelper::ModalBox.new(:id => 'my-modal') do
       @block
    end
  end

  #  <div id="my-modal" class="modal hide fade">
  #  <div class="modal-header">
  #    <a href="#" class="close">&times;</a>
  #
  #    <h3>Přijmout nabídku</h3>
  #  </div>
  #  <div class="modal-body">
  #    <p>help info</p>
  #  </div>
  #  <div class="modal-footer">
  #    <a href="#" class="btn secondary">Secondary</a>
  #  </div>
  #</div>

end
