require 'resque_spec'
require_relative '../resque/resque_tester'

describe Checker  do
  describe "#into_queue" do
    before(:each) do
      ResqueSpec.reset!
      @checker = Checker.new
    end

    it "adds an entry to the Checker queue" do
      @checker.into_queue
      Checker.should have_queued(@checker.time, :into_queue).in(:archives)
      Checker.should have_queue_size_of(1)
    end
  end
end
