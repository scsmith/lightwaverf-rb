require 'socket'

class LightwaveRF
  VERSION = "0.0.1"
  PORT = 9760

  attr_accessor :prefix

  def initialize
    @prefix = generate_prefix
  end

  def register
    generate_and_send_command(1, 1, "F0", 533)
  end

  def turn_on(room_number, device_number)
    generate_and_send_command(room_number, device_number, "F1")
  end

  def turn_off(room_number, device_number)
    generate_and_send_command(room_number, device_number, "F0")
  end

  def dim(room_number, device_number, percentage)
    generate_and_send_command(room_number, device_number, "FdP#{level(percentage)}")
  end

protected
  def level(percentage)
    1 + (percentage * 0.3125).to_i
  end

  def generate_prefix
    "%03d" % rand(99)
  end

  def generate_and_send_command(room_number, device_number, command, prefix = @prefix)
    generated_string = generate_command(room_number, device_number, command, prefix)
    send_command(generated_string)
  end

  def generate_command(room_number, device_number, command, prefix = @prefix)
    "#{prefix},!R#{room_number}D#{device_number}#{command}|"
  end

  def send_command(command)
    socket = UDPSocket.new
    socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
    socket.send(command, 0, "255.255.255.255", 9760)
    socket.close
  end
end

# lightwave = LightwaveRF.new
# lightwave.turn_on(1, 1)
# sleep(5)
# lightwave.dim(1, 1, 25)
# sleep(3)
# lightwave.dim(1, 1, 50)
# sleep(3)
# lightwave.dim(1, 1, 100)
# sleep(5)
# lightwave.turn_off(1, 1)
