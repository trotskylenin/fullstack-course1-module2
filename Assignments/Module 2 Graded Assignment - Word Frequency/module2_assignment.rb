class LineAnalyzer

  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = Array.new()
    self.calculate_word_frequency()
  end

  def calculate_word_frequency()
        countwords = Hash.new(0)
        linearr = @content.downcase.split(" ")
        linearr.each do |word|
          countwords[word] += 1
          if countwords[word] >= @highest_wf_count
            @highest_wf_count = countwords[word]
          end
        end
        countwords.each do |k, v|
          if v == @highest_wf_count
            @highest_wf_words << k
          end
        end
  end

end

class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def analyze_file()
    @analyzers = Array.new()
    c = 1
    File.open('test.txt', 'r') do |f|
      f.each_line do |line|
        @analyzers << LineAnalyzer.new(line, c)
        c += 1
      end
    end
  end

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = Array.new

    @analyzers.each do |lineanalyzer|
      if lineanalyzer.highest_wf_count > @highest_count_across_lines
        @highest_count_across_lines = lineanalyzer.highest_wf_count
      end
    end

    @analyzers.each do |lineanalyzer|
      if lineanalyzer.highest_wf_count == @highest_count_across_lines
          @highest_count_words_across_lines << lineanalyzer
      end
    end

  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format

  def print_highest_word_frequency_across_lines()
    puts @highest_count_across_lines
    @highest_count_words_across_lines.each do |lineanalyzer|
      lineanalyzer.highest_wf_words.each { |v| puts "#{v}" }
    end
  end

end
