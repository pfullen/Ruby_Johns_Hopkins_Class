#Implemrent all parts of this assignment within (this) module2_assignment2.rb file
#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  attr_reader :highest_wf_count #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  attr_reader :highest_wf_words #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  attr_reader :content          #* content          - the string analyzed (provided)
  attr_reader :line_number      #* line_number      - the line number analyzed (provided)

  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    # automatically analyze the line which will populate the highest_wf_* vars
    calculate_word_frequency()
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency
    # not a class method, it is used to poulate what are essentially properties on an instance of the class
    #word_frequency = @content.split(" ").each_with_object(Hash.new(0)) {|word,count| count[word] +=1}
    word_frequency = Hash.new(0)
    #puts word_frequency
    @content.split.each do |word|
      word_frequency[word] += 1
    end


    @highest_wf_count = word_frequency.values.max
    @highest_wf_words = word_frequency.select { |word, freq| freq == @highest_wf_count }.keys
    @highest_wf_words

  end
end



# That's it on the LineAnalyzer class. pretty simple

#  Implement a class called Solution.
class Solution
  # Implement the following read-only attributes in the Solution class.
  attr_reader :analyzers  #* analyzers - an array of LineAnalyzer objects for each line in the file
  attr_reader :highest_count_across_lines #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  attr_reader :highest_count_words_across_lines #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.

  def initialize(file_name = File.join("data", "opening_lines.txt"))
    @default_file = file_name
    # analyze_file(file_name)
    # call the calculate method(s) here
    # calculate_line_with_highest_frequency
    # print_highest_word_frequency_across_lines
  end

  # Implement the following methods in the Solution class.
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines
  #* Create an array of LineAnalyzers for each line in the file
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.

  def analyze_file (file_name = @default_file, max_lines = nil)
    @analyzers = []
    # this will get an instance of LineAnalyzer for each line of your data file into an array
    File.foreach(file_name).with_index do |line, line_number|
      # << is a common shorthand to append an item to an array
      @analyzers << LineAnalyzer.new(line, line_number + 1) # add one because line_number will start at 0
      break if !max_lines.nil? && line_number + 1 >= max_lines
    end
     @analyzers # so we can examine the return
  end

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and
  #  highest_count_words_across_lines attribute values

  def calculate_stats(analyzers_array = nil)
    analyzers_array = @analyzers if analyzers_array.nil?
    # this one gets the anaylyzer
    analyzer_w_most_repeated_word = analyzers_array.max_by { |analyzer| analyzer.highest_wf_count }
    #this one gets its highest word count
    @highest_count_across_lines = analyzer_w_most_repeated_word.highest_wf_count

    # this one gets all lines that match that highest word count - it will be an array of objects
    # containing one or more objects
    @highest_count_words_across_lines = analyzers_array.select { |e| e.highest_wf_count == @highest_count_across_lines }

    # return a hash with some useful info
    { top_line: analyzer_w_most_repeated_word, repeat_word_count: @highest_count_across_lines,
      top_line_and_ties: @highest_count_words_across_lines }
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in
  #  highest_count_words_across_lines in the specified format

  def print_highest_word_frequency_across_lines
    puts "The line(s) with most repeated words are:"
    @highest_count_words_across_lines.each do |line|
      # using string interpolation here, also combining into one line
      puts "\tLine #{line.line_number}: (#{line.highest_wf_words.join(", ")}), appears #{@highest_count_across_lines
        } times\n#{word_wrap(line.content, 80, 2)}"
    end
  end

  def word_wrap(string_to_wrap, line_length = 80, tabs_to_indent = 2, new_line = "\n")
    tabs = "\t" * tabs_to_indent
    tab_length = 8
    lines = []
    line = ""
    effective_line_length = line_length - 1 - (tabs_to_indent * tab_length)
    words = string_to_wrap.split(" ")
    words.each do |word|
      if line.length + 1 + word.length > effective_line_length
        lines << "#{tabs}#{line}"
        line = ""
      end
      line += " #{word}"
    end
    lines.join(new_line)
  end
end

require 'pry'

sol = Solution.new
sol.analyze_file #('./data/opening_lines.txt')
sol.calculate_stats
sol.print_highest_word_frequency_across_lines
binding.pry

