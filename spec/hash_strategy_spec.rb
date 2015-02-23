require "spec_helper"

describe Flip::HashStrategy do
  let(:hash) { { "flip_one" => "true", "flip_two" => "false" } }

  let(:strategy) do
    Flip::HashStrategy.new.tap do |s|
      s.stub(:hash) { hash }
    end
  end

  its(:description) { should be_present }
  it { should be_switchable }

  it_behaves_like "an interrogatable hash"
  it_behaves_like "a switchable hash"
end
