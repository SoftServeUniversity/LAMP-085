require File.expand_path './spec/spec_helper'
require File.expand_path './lib/hw_checker'

describe String do
  before(:each) do
    module A
      module B
        class C
        end
      end
    end
  end
  it 'should constatize correctly' do
    string = "A::B::C"
    string.constatize.should == A::B::C
  end  
end