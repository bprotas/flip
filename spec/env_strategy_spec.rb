require "spec_helper"

describe Flip::EnvStrategy do
  let(:env_hash) { { "FLIP_ONE" => "true", "FLIP_TWO" => "false" } }
  let(:strategy) { Flip::EnvStrategy.new }

  before { stub_const "ENV", env_hash }

  its(:description) { should be_present }
  it { should_not be_switchable }

  it_behaves_like "an interrogatable hash"
end
