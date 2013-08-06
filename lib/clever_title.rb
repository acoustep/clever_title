class String
  def clever_title args = {}
    clever = CleverTitle.new self, args
    clever.title
  end
end

class CleverTitle
  attr_accessor :title, :max_downcase_conversion, :capitalize_first_letter

  @@conjunctions = %w(and or but nor so for yet after although long as because before even if even though if once provided since that though till unless until what when whenever wherever whether while)

  @@prepositions = %w(aboard about above across after against along amid among anti around as at before behind below beneath beside besides between beyond but by concerning considering despite down during except excepting excluding following for from in inside into like minus near of off on onto opposite outside over past per plus regarding round save since than through to toward towards under underneath unlike until up upon versus via with within without)

  def initialize(title, args = {})
    @title = title
    @max_downcase_conversion = 4
    @max_downcase_conversion = args[:max_downcase_conversion] if args[:max_downcase_conversion]
    @capitalize_first_letter = true unless args[:capitalize_first_letter] == false
    self.run
  end

  protected

  def run
    capitalise
    # lower_conjunctions
    lower_words
    capitalise_first_word if @capitalize_first_letter
  end

  def capitalise
    @title = @title.split.map(&:capitalize).join(' ')
  end

  def lower_words
    all_words = (@@conjunctions << @@prepositions).flatten!
    all_words = all_words.uniq
    words_to_filter = all_words
    words_to_filter = all_words.select { |x| x if x.length <= @max_downcase_conversion } if @max_downcase_conversion
    words = @title.split
    fixed = words.map { |w| if words_to_filter.include? w.downcase then w.downcase! else w end }
    @title = fixed.join ' '
  end

  def capitalise_first_word
    @title = @title.slice(0,1).upcase + @title.slice(1..-1)
  end

  def seperate_words
    @title.split(/\W+/)
  end
end
