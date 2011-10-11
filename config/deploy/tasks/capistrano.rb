# -*- encoding : utf-8 -*-
Capistrano::Configuration.instance(true).load() do

  def ui
    Capistrano::CLI.ui
  end

end
