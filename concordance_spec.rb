require 'minitest/autorun'
require 'minitest/pride'
require_relative 'concordance'

describe Concordance do
  subject               { Concordance.new(paragraph) }
  let(:paragraph)       { "Testing this method call i.e. testing" }
  let(:big_paragraph)   { File.read("fixtures/paragraph.txt") }
  let(:big_concordance) { Concordance.new(big_paragraph) }
  let(:concordance) do
    { 
      a: [2, 1, 1],
      all: [1, 1],
      alphabetical: [1, 1],
      an: [2, 1, 1],
      appeared: [1, 2],
      arbitrary: [1, 1],
      bonus: [1, 2],
      concordance: [1, 1],
      document: [1, 1],
      each: [2, 2, 2],
      english: [1, 1],
      frequencies: [1, 1],
      generate: [1, 1],
      given: [1, 1],
      :"i.e." => [1, 1],
      in: [2, 1, 2],
      label: [1, 2],
      labeled: [1, 1],
      list: [1, 1],
      numbers: [1, 2],
      occurrence: [1, 2],
      occurrences: [1, 1],
      of: [1, 1],
      program: [1, 1],
      sentence: [1, 2],
      text: [1, 1],
      that: [1, 1],
      the: [1, 2],
      which: [1, 2],
      will: [1, 1],
      with: [2, 1, 2],
      word: [3, 1, 1, 2],
      write: [1, 1],
      written: [1, 1]
    }
  end

  it "is initialized with a string of arbitrary length" do
    subject
    big_concordance
    proc { Concordance.new }.must_raise ArgumentError
  end

  describe "#sentences" do
    it "splits the paragraph into an array of sentences" do
      subject.sentences.must_equal ["Testing this method call i.e. testing"]
      big_concordance.sentences.must_equal([
        "Given an arbitrary text document written in English, write a program that will generate a concordance, i.e. an alphabetical list of all word occurrences, labeled with word frequencies.",
        "Bonus: label each word with the sentence numbers in which each occurrence appeared."
      ])
    end
  end
  
  describe "#words_for" do
    it "divides the sentence into its individual words as symbols" do
      subject.words_for(paragraph).must_equal([:call, :"i.e.", :method, :testing, :testing, :this])
    end
  end

  describe "#words_to_hash" do
    it "returns a hash where each unique words is a key with a corresponding count value of 0" do
      subject.words_to_hash.must_equal({
        testing:   [0],
        this:      [0], 
        method:    [0],
        call:      [0],
        :"i.e." => [0]
      })
    end
  end

  describe "#count" do
    it "returns a hash with each unique word as a key & its # of occurrences as the value" do
      subject.count.must_equal({
        testing:   [2, 1, 1],
        this:      [1, 1],
        method:    [1, 1],
        call:      [1, 1],
        :"i.e." => [1, 1]
      })

      big_concordance.count.must_equal(concordance)
    end
  end
end
