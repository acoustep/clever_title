# A module for more accurate titles
module CleverTitle
	# The string that needs to be title case
  attr_accessor :title
	# The maximum amount of letters to lower case conjunctions and prepositions
	attr_accessor :max_downcase_conversion
	# Whether to capitalise the first letter of the string
	attr_accessor :capitalize_first_letter
	# Capitalize after full stop and atleast 1 space
	attr_accessor :capitalize_after_period

	# A list of conjunctions for lowercase
  @@conjunctions = %w(and or but nor so for yet after although long as because before even if even though if once provided since that though till unless until what when whenever wherever whether while)

	# A list of prepositions for lowercase
  @@prepositions = %w(aboard about above across after against along amid among anti around as at before behind below beneath beside besides between beyond but by concerning considering despite down during except excepting excluding following for from in inside into like minus near of off on onto opposite outside over past per plus regarding round save since than through to toward towards under underneath unlike until up upon versus via with within without)

	#Call this function on a string to add title case
	#
	#Optionally configure max_downcase_conversion and capitalize_first_letter
	#
	#== Example #1
	#
	#	"hello world".clever_title # "Hello World"
	#
	#== Example #2
	#
	#	"hello world".clever_title(max_downcase_conversion: 5) # "Hello World"
  def clever_title args = {} # :args: :max_downcase_conversion, :capitalize_first_letter
    @title = self
    @max_downcase_conversion = 4
    @max_downcase_conversion = args[:max_downcase_conversion] if args[:max_downcase_conversion]
    @capitalize_first_letter = true unless args[:capitalize_first_letter] == false
    @capitalize_after_period = true unless args[:capitalize_after_period ] == false
    self.run
    @title
  end

	# Call this function to replace the current string permanently
  def clever_title! args = {} # :args: :max_downcase_conversion, :capitalize_first_letter
    @title = self
    @max_downcase_conversion = 4
    @max_downcase_conversion = args[:max_downcase_conversion] if args[:max_downcase_conversion]
    @capitalize_first_letter = true unless args[:capitalize_first_letter] == false
    @capitalize_after_period = true unless args[:capitalize_after_period ] == false
    self.run
		self.replace(@title)
    @title
  end

  protected

	# Called from the clever_title method to run through functionality
  def run
    capitalise
    # lower_conjunctions
    lower_words
    capitalise_first_word if @capitalize_first_letter
		capitalise_after_period if @capitalize_after_period
  end

	# capitalise each word
  def capitalise
    @title = @title.split.map(&:capitalize).join(' ')
  end

	# Find conjunctions and prepositions that need to be lower case
  def lower_words
    all_words = (@@conjunctions << @@prepositions).flatten!
    all_words = all_words.uniq
    words_to_filter = all_words
    words_to_filter = all_words.select { |x| x if x.length <= @max_downcase_conversion } if @max_downcase_conversion
    words = @title.split
    fixed = words.map { |w| if words_to_filter.include? w.downcase then w.downcase! else w end }
    @title = fixed.join ' '
  end

	# Capitalise first word in the string
  def capitalise_first_word
    @title = @title.slice(0,1).upcase + @title.slice(1..-1)
  end
	# Capitalise first word after a period
  def capitalise_after_period
		@title = @title.gsub(/(\.(\s+)([a-z]))/) {|word| word.upcase }
  end

  def seperate_words
    @title.split(/\W+/)
  end
end
