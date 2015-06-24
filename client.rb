#!/usr/bin/env ruby

##
# client.rb -- the client program for my Teensy-based mixer thing
# author: Miles Frankel (miles.frankel at gmail.com)
##

# require 'pry'
require 'serialport'

def inputs_readout  # TODO: check for failure
  inputs = `pactl list sink-inputs`
  inp_list = (inputs.split(/Sink Input/)).map do |s|
    s.lstrip.rstrip if s != ''
  end .compact
  inp_nums = inp_list.map do |s|
    s.match(/^#([0-9]+)/).captures
  end .flatten
  prog_name = inp_list.map do |s|
    s.match(/application.process.binary = "([a-zA-Z0-9\-_]+)"/).captures
  end .flatten
  Hash[prog_name.zip(inp_nums)]
end

def update_stream_vol(num, vol)
  %x(pactl set-sink-input-volume #{num} #{vol}%)
end

def update_prog_vol(name, vol)
  streams = inputs_readout
  update_stream_vol(streams[name], vol)
end

def setstty(dev = '/dev/ttyACM0', baud = 115_200)
  # set the serial output of the teensy properly.
  %x(stty -F #{dev} cs8 #{baud} ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts)
  nil
end

def setup_serial(dev = '/dev/ttyACM0', baud = 115_200)
  setstty(dev, baud) # required i think
  data_bits = 8
  stop_bits = 1
  parity = SerialPort::NONE
  SerialPort.new(dev, baud, data_bits, stop_bits, parity)
end

def main
  sp = setup_serial  # use default values
  while (line = sp.gets.chomp)
    trap('INT') do # trap ctrl-c and close connection gracefully
      sp.close
      puts 'Exiting...'
      exit
    end
    vols = line.split(' ').map(&:to_f)
    puts vols.to_s + "\n\n" # for debugging
    # temporary; TODO: hash to store which slider goes to which program
    inputs_readout.each_with_index do |(k, _a), i|
      # convert 10-bit num into percent
      volume = ((vols[i] / 1024) * 100).to_i
      update_prog_vol(k, volume)
    end
  end
  sp.close
end

main
