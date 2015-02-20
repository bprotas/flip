require "spec_helper"

describe Flip::EnvStrategy do
  let(:environment) { { "flip_one" => "true", "flip_two" => "false" } }
  let(:strategy) do
    Flip::EnvStrategy.new.tap do |s|
      s.stub(:env) { environment }
    end
  end

  its(:description) { should be_present }
  it { should_not be_switchable }

  context "enabled feature" do
    specify "#knows? is true" do
      strategy.knows?(:one).should be_true
    end

    specify "#on? is true" do
      strategy.on?(:one).should be_true
    end
  end

  context "disabled feature" do
    specify "#knows? is true" do
      strategy.knows?(:two).should be_true
    end

    specify "#on? is false" do
      strategy.on?(:two).should be_false
    end
  end

  context "feature unknown to strategy" do
    specify "#knows? is false" do
      strategy.knows?(:three).should be_false
    end

    specify "#on? is false" do
      strategy.on?(:three).should be_false
    end
  end
end

