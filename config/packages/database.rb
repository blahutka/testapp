package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client )
  verify { has_apt 'mysql-server' }
end

package :mysql_driver do
  description 'Ruby MySQL database driver'
  gem 'mysql'
  verify { has_gem 'mysql' }
end
