module FormHelper
#
#  class MyForm < Erector::Widget
#
#    class << self
#
#      def rows(&block)
#        _rows << block
#      end
#
#      def _rows
#        @rows ||= []
#      end
#
#    end
#
#    def content
#      div do
#        self.class._rows.each do |row|
#          self.instance_exec(&row)
#        end
#      end
#    end
#
#  end
#
#  class ProfileForm < FormHelper::MyForm
#    rows do |v|
#      #link_to 'test'
#    end
#  end
#
#  def table(&block)
#    FormHelper::ProfileForm.new().to_html(:helpers => block)
#  end
#
#
end