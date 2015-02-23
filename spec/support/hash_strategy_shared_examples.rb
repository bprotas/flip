shared_examples_for "an interrogatable hash" do
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

shared_examples_for "a switchable hash" do
  it "can switch known features on" do
    strategy.switch! :two, true
    strategy.on?(:two).should be_true
  end

  it "can switch known features off" do
    strategy.switch! :one, false
    strategy.on?(:one).should be_false
  end

  it "can switch unknown features on" do
    strategy.switch! :three, true
    strategy.on?(:three).should be_true
  end

  it "can delete knowledge of a feature" do
    strategy.delete! :one
    strategy.on?(:one).should be_false
    strategy.knows?(:one).should be_false
  end
end
