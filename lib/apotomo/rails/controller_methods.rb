module Apotomo
  module Rails
    module ControllerMethods
      def render_event_response
        page_updates = apotomo_request_processor.process_for(params)

        return render_iframe_updates(page_updates) if params[:apotomo_iframe]

        render :text => page_updates.join("\n"), :content_type => Mime::HTML
      end
    end
  end
end