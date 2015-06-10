#!/usr/bin/env ruby
def inputs_readout
  inputs = `pactl list sink-inputs`
  inp_list = (inputs.split /Sink Input/).map do |s|
    s.lstrip.rstrip if s != ''
  end .compact
  cur_vols = inp_list.map do |s|
    (s.match /([0-9]{1,3}%)/).captures
  end .flatten
  inp_nums = inp_list.map do |s|
    (s.match /^#([0-9]+)/).captures
  end .flatten
  prog_name = inp_list.map do |s|
    (s.match /application.process.binary = "([a-zA-Z0-9\-_]+)"/).captures
  end .flatten
  Hash[prog_name.zip(inp_nums.zip(cur_vols))]
end
def read_serial
  file = './testing/test'
  line = %x(tail -n 1 #{file}).lstrip.rstrip
  line.split(' ').map(&:to_f)
end
def update_stream_vol(num, vol)
  %x(pactl set-sink-input-volume #{num} #{vol}%)
end
def update_prog_vol(name, vol)
  streams = inputs_readout
  update_stream_vol(streams[name][0], vol)
end

def setstty
  # set the serial output of the teensy properly. Needs to be run whenever it is rebooted or reconnected, but doesn't hurt to run more often than that
  #  `stty -F /dev/ttyACM0  cs8 115200 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts`
  nil
end


def main
  setstty
  while true do
    vols = read_serial
    streams = inputs_readout
    streams.each_with_index do |(k, _a), i|
      volume = ((vols[i] / 1024) * 100).to_i
      update_prog_vol(k, volume)
    end
  end
end

main
