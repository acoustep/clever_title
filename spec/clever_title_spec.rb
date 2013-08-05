require 'spec_helper'

describe CleverTitle do
  it "should be an instance of CleverTitle" do
    clever_title = CleverTitle.new "test"
    clever_title.should be_kind_of CleverTitle
  end

  it "should return a string" do
    clever_title = "hello".clever_title
    clever_title.should be_kind_of String
  end

  it "should change all capitals to title case" do
    clever_title = "HELLO".clever_title
    clever_title.should eql "Hello"
  end

  it "should change conjunctions to all lower case" do
    clever_title = "AND iF Yet".clever_title
    clever_title.should eql "and if yet"
  end
  it "should keep conjunctions above 4 words capitalised by default" do
    clever_title = "Cornelius provided the man ABOARD the boat WITH TWO FISH AFTER".clever_title
    clever_title.should eql "Cornelius Provided The Man Aboard The Boat with Two Fish After"
  end
  
  it "should capitalise conjunctions above 5 if set to 6" do
    clever_title = "Cornelius provided the man ABOARD the boat WITH TWO FISH AFTER".clever_title(max_downcase_conversion: 6)
    clever_title.should eql "Cornelius Provided The Man aboard The Boat with Two Fish after"
  end
end
