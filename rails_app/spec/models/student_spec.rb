require 'spec_helper'

describe Student do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should have_many :reports }
  it { should have_many(:homeworks).through(:reports) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name).with_message(/^[a-z]+.[a-z]+$/i) }
end
