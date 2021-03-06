require 'spec_helper'

describe CleverTitle do
  before(:all) do
    class String
      include CleverTitle
    end
  end
  it "should be an instance of String" do
    clever_title = "test".clever_title
    clever_title.should be_kind_of String
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
    clever_title.should eql "And if yet"
  end
  it "should keep conjunctions above 4 words capitalised by default" do
    clever_title = "Cornelius provided the man ABOARD the boat WITH TWO FISH AFTER".clever_title
    clever_title.should eql "Cornelius Provided The Man Aboard The Boat with Two Fish After"
  end
  
  it "should capitalise conjunctions above 5 if set to 6" do
    clever_title = "Cornelius provided the man ABOARD the boat WITH TWO FISH AFTER".clever_title(max_downcase_conversion: 6)
    clever_title.should eql "Cornelius Provided The Man aboard The Boat with Two Fish after"
  end

  it "should make conjunctions at the beginning of the string uppercase" do
    clever_title = "and nothing else matters".clever_title capitalize_first_letter: true
    clever_title.should eql "And Nothing Else Matters"
  end

  it "should make conjunctions at the beginning of the string uppercase by default" do
    clever_title = "and nothing else matters".clever_title
    clever_title.should eql "And Nothing Else Matters"
  end

  it "should make conjunctions at the beginning of the string lowercase if capitalize_first_letter is set to false" do
    clever_title = "and nothing else matters".clever_title capitalize_first_letter: false
    clever_title.should eql "and Nothing Else Matters"
  end

	it "should capitalize the next letter after a period and one or more spaces" do
		clever_title = "This is Sentence One. and this is Sentence Two".clever_title
		clever_title.should eql "This Is Sentence One. And This Is Sentence Two"
	end

	it "should capitalize the next letter after a period and one or more spaces on multiple sentences" do
		clever_title = "This is Sentence One. and this is Sentence Two. yet this is Sentence Two".clever_title
		clever_title.should eql "This Is Sentence One. And This Is Sentence Two. Yet This Is Sentence Two"
	end
	
	it "should not capitalize after period if :capitalize_after_period is false" do
		clever_title = "This is Sentence One. and this is Sentence Two. yet this is Sentence Two".clever_title capitalize_after_period: false
		clever_title.should eql "This Is Sentence One. and This Is Sentence Two. yet This Is Sentence Two"
	end

	it "should not alter the string it's run on" do
		title = "temporary"
		temporary = title.clever_title.should eql "Temporary"
		title.should eql "temporary"
	end

	it "should alter the string if clever_title! is run" do
		title = "temporary"
		temporary = title.clever_title!.should eql "Temporary"
		title.should eql "Temporary"
	end
end
