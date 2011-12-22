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
    needs :id, :options

    def initialize(*args)
      super
      @buttons, @body, @js, @replace = nil
      yield self if block_given?
    end


    def js(action, id, template)
      @js = lambda {
        id = dom_id(id) if id.respond_to?(:id)
        text! <<-TXT
           $('.modal #{id}').#{action.to_s}('#{escape_javascript(template)}');
        TXT
      }
    end

    def content
      # hide fade
      clazz = ['modal', 'hide', 'fade']
      clazz.delete('hide') and clazz.delete('fade') if @options[:show]

      div :id => @id, :class => clazz.join(' '), :style => @options[:style] do
        #div :class => 'modal-header' do
        #  link_to 'x', '#', :class => 'close'
        #  h3 'Header'
        #end
        #div :class => 'modal-body' do
        #  div :class => 'wrap body' do
        #    @body if @body
        #  end
        #end
        #
        #div :class => 'modal-footer footer' do
        #  link_to 'Continue', root_path, :class => 'btn primary'
        #  @buttons.call if @buttons
        #end
        @body if @body

      end #if @body || @buttons || @options[:empty]

      @js.call if @js
      @replace.call if @replace
    end


  end

  def modal_window(options = {}, &block)
    ApplicationHelper::ModalBox.new(:id => options[:id], :options => options, &block).to_html
  end

  class FormForModal < Erector::Widget

    def initialize(*args)
      @body, @title, @form = nil
      @buttons = []
      super
      yield(self, @form) if block_given?
    end

    def to_js

    end

    def body(&block)
      @body = block
    end

    def buttons(options={}, &block)
      @buttons << block
      @buttons.push(lambda { link_to 'Zrušit', '#', :class => 'btn', 'data-dismiss' => "modal" }) if options[:cancel]
    end

    def header(title)
      @title = title
    end

    def form_f(options={}, &block)
      @form = block
    end

    def content

      div :class => 'modal-header' do
        link_to 'x', '#', :class => 'close', 'data-dismiss' => "modal"
        h3 @title.presence || 'Header'
      end

      div :class => 'modal-body' do
        div :class => 'wrap body' do
          @body.call if @body
        end
      end

      div :class => 'modal-footer footer' do

        @buttons.each(&:call) unless @buttons.empty?
      end

    end
  end

  def form_for_modal(options = {}, &block)
    ApplicationHelper::FormForModal.new(&block).to_html
  end


  def hide(show = false, &code)
    show ? return : yield
  end

  ##########################

  class MyForm < Erector::Widget

    class << self

      def rows(&block)
        _rows << block
      end

      def _rows
        @rows ||= []
      end

     
    end

    def content
      div do

        self.class._rows.each do |row|
          self.instance_exec(&row)
        end
      end
    end

  end

  class ProfileForm < MyForm

      rows do
        link_to 'prvni'

      end

    rows do
      link_to 'druh'
    end
  end


end
