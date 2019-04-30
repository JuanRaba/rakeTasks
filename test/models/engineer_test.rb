require 'test_helper'

class EngineerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "engineers(:one).name" do
    engineers(:one).set_xp
    assert engineers(:one).xp == 0
  end

  test "engineers(:two).name" do
    engineer = engineers(:two)
    engineer.set_xp
    assert engineer.xp == 20
  end

  test "engineers(:three).name" do
    engineer = engineers(:three)
    engineer.set_xp
    assert engineer.xp == 20
  end

  test "engineers(:four).name" do
    engineer = engineers(:four)
    engineer.set_xp
    assert engineer.xp == 10
  end
end
