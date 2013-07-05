require 'spec_helper'

describe 'Browser' do
  before do
    use_device :my_tablet
  end

  context 'surfing the web' do
    it 'launches hacker news' do
      my_tablet.launch_home
      my_tablet.click_text 'Chrome'
      my_tablet.fill_in 'Search, or say Google', with: 'http://news.ycombinator.com'
      expect(my_tablet).to have_text 'Hacker News'
    end
  end
end
