class Admin::VanityController < ApplicationController
  layout false
  include Vanity::Rails::Dashboard
end
