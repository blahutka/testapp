namespace :mini_record do
  desc "Auto migration of database"
  task :migrate => :environment do
    Dir["app/models/*.rb"].each do |file_path|
      basename = File.basename(file_path, File.extname(file_path))
      clazz = basename.camelize.constantize
      clazz.auto_upgrade!
    end
  end
end