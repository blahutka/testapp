module FactoryGirl
  def self.reload_definitions #:nodoc:
    self.factories.clear
    definition_file_paths.each do |path|
      load("#{path}.rb") if File.exists?("#{path}.rb")

      if File.directory? path
        Dir[File.join(path, '*.rb')].each do |file|
          load file
        end
      end
    end
  end
end