require 'test_helper'

class WitnessTest < ActiveSupport::TestCase
  test "privacy withholds witness name and contact details" do
    witness = witnesses(:alice)

    privacy_withheld_str = '(Withheld)'

    witness.privacy = Witness.privacy_levels[:private]
    assert_equal privacy_withheld_str, witness.name, 'Witness name not withheld when privacy set to private'
    assert_equal privacy_withheld_str, witness.contact, 'Witness contact details not withheld when privacy set to private'

    witness.privacy = Witness.privacy_levels[:public]
    refute_equal privacy_withheld_str, witness.name, 'Witness name withheld when privacy set to public'
    refute_equal privacy_withheld_str, witness.contact, 'Witness contact details withheld when privacy set to public'
  end

  test "can set private levels via level, string, and symbol" do
    witness = Witness.new

    inputs = [0, :public, "Public"]
    inputs.each do |input|
      assert_nil witness.privacy_level
      witness.privacy = input
      assert_equal Witness.privacy_levels[:public], witness.privacy_level
      witness.privacy_level = nil
    end
  end

  test "correct mapping of privacy level to canonical meanings" do
    assert_equal 0, Witness.privacy_levels[:public]
    assert_equal 1, Witness.privacy_levels[:private]
  end

  test "can get human-readble privacy setting" do
    witness = witnesses(:alice)
    witness.privacy = Witness.privacy_levels[:private]
    assert_equal 'Private', witness.privacy

    witness.privacy = Witness.privacy_levels[:public]
    assert_equal 'Public', witness.privacy
  end
end
