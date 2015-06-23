#!/usr/bin/env ruby

require 'serialport'

port_str = "/dev/ttyACM0"
baud = 115200
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud, data_bits, stop_bits, parity)

while true do
  while (i = sp.gets.chomp) do
    puts i
    trap('INT') { sp.close ; puts 'Exiting...'; exit } # trap ctrl-c
  end
end

sp.close
