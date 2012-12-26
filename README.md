# LightwaveRF

Control LightwaveRF devices with the Wifi Link box.
Messages are sent over UDP broadcast, so you need to be on the same network and subnet.

## Installation

Add this line to your application's Gemfile:

    gem 'lightwave_rf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lightwave_rf

## Usage

    lightwave = LightwaveRF.new

    # Initial Registration (Only needs doing once per device)
    lightwave.register

    # Turn the light on in room 1, device number 1
    lightwave.turn_on(1, 1)

    # Dim the lights in room 2, device number 3 after turning them on
    lightwave.turn_on(2, 3)
    lightwave.dim(2, 3, 50)

    # Turn off the lights
    lightwave.turn_off(1, 1)
    lightwave.turn_off(2, 3)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
