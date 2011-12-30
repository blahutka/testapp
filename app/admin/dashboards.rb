# -*- encoding : utf-8 -*-
ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #

  section 'Map' do
    render :partial => 'map'
  end

  section "Poslední žádosti 1" do
    ul do
      SkillRequest.order('updated_at ASC').limit(5).collect do |request|
        li (request.state << '&nbsp;'.html_safe << link_to(request.title, admin_skill_request_path(request))).html_safe

      end
      #Post.recent(5).collect do |post|
      #  li link_to(post.title, admin_post_path(post))
      #end
    end
  end

  section "Poslední žádosti 2" do
    ul do
      SkillRequest.order('updated_at ASC').limit(5).collect do |request|
        li (request.state << '&nbsp;'.html_safe << link_to(request.title, admin_skill_request_path(request))).html_safe

      end
      #Post.recent(5).collect do |post|
      #  li link_to(post.title, admin_post_path(post))
      #end
    end
  end

  section "Poslední žádosti 3" do
    ul do
      SkillRequest.order('updated_at ASC').limit(5).collect do |request|
        li (request.state << '&nbsp;'.html_safe << link_to(request.title, admin_skill_request_path(request))).html_safe

      end
      #Post.recent(5).collect do |post|
      #  li link_to(post.title, admin_post_path(post))
      #end
    end
  end
    section "Poslední žádosti 4" do

    ul do
      SkillRequest.order('updated_at ASC').limit(5).collect do |request|
        li ( request.state << '&nbsp;'.html_safe << link_to(request.title, admin_skill_request_path(request)) ).html_safe

      end
      #Post.recent(5).collect do |post|
      #  li link_to(post.title, admin_post_path(post))
      #end
    end
  end

  section "Recent User" do
    ul do
      User.limit(5).collect do |user|
        li link_to(user.last_name, admin_user_path(user))
      end
      #Post.recent(5).collect do |post|
      #  li link_to(post.title, admin_post_path(post))
      #end
    end
  end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
