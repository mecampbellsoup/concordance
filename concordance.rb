class Concordance
  def initialize(paragraph)
    @paragraph = paragraph.strip
  end

  def words_for(string)
    string.split(" ").
      map { |w| w.count(".") > 1 ? w : w.chomp(".") }.
      map { |w| w.chomp(",") }.
      map { |w| w.chomp(":") }.
      map(&:downcase).map(&:to_sym).sort
  end

  def count
    @count ||= sentences.each_with_index do |s, i|
      words_for(s).each do |w|
        words_to_hash[w][0] = words_to_hash[w][0] + 1
        words_to_hash[w].push(i + 1)
      end
    end
    words_to_hash
  end

  def sentences
    @sentences ||= paragraph.gsub(/\w{2}[.?!]/, '\0|').split("|").map(&:strip)
  end

  def words_to_hash
    @words_to_hash ||= words_for(paragraph).inject({}) { |k, v| k[v] = Array(0); k }
  end

  private

  attr_reader :paragraph
end
