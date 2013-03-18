module Honeydew
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/honeydew.rake'
    end
  end
end