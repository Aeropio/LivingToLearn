require 'test_helper'

class SchoolTest < ActiveSupport::TestCase

  def setup
  end

  def test_should_be_able_to_add
    cnt= Government::Government.add_entity(Government::School,{:name=>"Camden"})
    assert_equal cnt.errors.count, 0
    assert_equal cnt.entity_details.count , 1
  end

  def test_should_not_be_able_to_add_wo_name
    cnt= Government::Government.add_entity(Government::School,{})
    assert_equal cnt.errors.count, 1
  end

end