package :mongrel do
  description 'Mongrel Application Server'
  gem 'mongrel'
  version '1.1.5'
  verify { has_gem 'mongrel', version }
end

package :mongrel_cluster, :provides => :appserver do
  description 'Cluster Management for Mongrel'
  gem 'mongrel_cluster'
  version '1.0.5'
  requires :mongrel
  verify { has_gem 'mongrel_cluster', version }
end

package :apache, :provides => :webserver do
  description 'Apache 2 HTTP Server'
  version '2.2.19'
  source "http://www.apache.org/dist/httpd/httpd-#{version}.tar.bz2" do
    enable %w( mods-shared=all proxy proxy-balancer proxy-http rewrite cache headers ssl deflate so )
    prefix "/opt/local/apache2-#{version}"
    post :install, 'install -m 755 support/apachectl /etc/init.d/apache2', 'update-rc.d -f apache2 defaults'
    #post :install, '/etc/init.d/apache2 restart'
  end
  requires :apache_dependencies
  optional :start_apache2, :add_users
  verify { has_executable '/etc/init.d/apache2' }
end

package :apache_dependencies do
  description 'Apache 2 HTTP Server Build Dependencies'
  apt %w( openssl libtool mawk zlib1g-dev libssl-dev )
end

package :start_apache2 do
  description "Start Apache server"
  noop do
    pre :install, 'sudo service apache2 start'
  end

  optional(:add_users)
  verify { has_process 'httpd' }
end

package :add_users do
  description 'User for deployment'

  add_user 'blahutka', :flags => '--disabled-password --system --ingroup deploy' do
    pre :install, 'sudo addgroup deploy'
  end

  verify { has_user 'blahutka' }
end

