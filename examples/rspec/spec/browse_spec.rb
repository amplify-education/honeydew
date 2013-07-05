require 'spec_helper'

describe 'Browsing the web' do
  it 'can launch a browser and visit hacker news' do
    use_device :my_tablet
    my_tablet.launch_home
  end
end
