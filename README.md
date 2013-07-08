# Honeydew

NOTE: Honeydew is currently in alpha and is not quite ready for use.

Honeydew is a Ruby driver for UIAutomator which enables automated testing of
Android devices.

## Installation

Install the honeydew gem:

    $ gem install honeydew

Or if you're using Bundler, add honeydew to your Gemfile:

    gem 'honeydew'

You'll need to have the Android SDK installed, ANDROID_HOME set correctly as
well as Maven.

## Using Honeydew

In typical operation, Honeydew connects to the first Android device connected
to your system which has debugging enabled. You can send commands to this
device like so:

``` ruby
    Honeydew.current_device.launch_home
    Honeydew.
```

If you want to interact with multiple Android devices at the same time, you can
create separate device instances by specifying their serial IDS. You can get
the serial IDs of all android devices connected to your system with the ``adb
devices -l``` command, e.g:

    $ adb devices -l
    List of devices attached

Once you have the serial ID of a device you wish to control, create a device
object for it:

``` ruby
    nexus = Honeydew::Device.new ''
```

Then you can begin issuing commands:

``` ruby
    nexus.click_text 'Android Air-Hockey'
    if nexus.has_text? 'New Game'
      nexus.click_button 'New Game'
    ...
```

## Using Honeydew with RSpec

Honeydew comes with a DSL that can be used in RSpec as well as matchers for use
with RSpec.

## Using Honeydew with Cucumber

If you're using Cucumber, Honeydew comes with a DSL that can ease the creation
of device related steps. Firstly require the honeydew cucumber files:

``` ruby
    require 'honeydew/cucumber'
```

This adds the Honeydew DSL to World so you can interact with the device in your
steps like so:

``` ruby
    using_device :teacher_tablet
    teacher_tablet.launch_settings
```

## Controlling Android Devices

Honeydew provides a number of methods for interacting with an Android device.

## Thanks

Honeydew is sponsored by [Amplify](http://www.amplify.com/) and was created by
[Selvakumar Natesan](https://github.com/selvakn) and [Christopher
Rex](https://github.com/christopher-rex) of
[ThoughtWorks](http://www.thoughtworks.com/).

Additional thanks to [Shyam Vala](https://github.com/shyamvala), [Premanand
Chandrasekaran](https://github.com/premanandc) and [John
Barker](https://github.com/excepttheweasel/) for multi device support, testing
and a little bit of polish.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
