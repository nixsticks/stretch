@events = {}
@setups = []

def event(name, &block)
  @events[name] = block
end

def setup(&block)
  @setups << block
end

event "the sky is falling" do
  @sky_height < 300
end

event "it's getting closer" do
  @sky_height < @mountains_height
end

setup do 
  puts "Setting up sky"
  @sky_height = 100
end

setup do
  puts "Setting up mountains"
  @mountains_height = 200
end

def run
  @events.each do |name, block|
    @setups.each {|block| block.call}
    puts "ALERT: #{name}" if block.call
  end
end

run