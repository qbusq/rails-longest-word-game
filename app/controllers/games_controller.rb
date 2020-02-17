require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    @letters = (0...9).map { ('A'..'Z').to_a[rand(26)] }.join
  end

  def score
    word_array = params[:word].split('')
    freq = Hash.new(0)
    word_array.each { |letter| freq[letter] += 1 }
    frequencies = Hash.new(0)
    aletters = params[:random].split('')
    aletters.each { |letter| frequencies[letter] += 1 }
    url = 'https://wagon-dictionary.herokuapp.com/' + params[:word]
    word_serialized = open(url).read
    match = JSON.parse(word_serialized)

    if (freq.to_a - frequencies.to_a).empty?
      if match[:found]
        1
      else
        2
      end
    else
      3
    end
  end
end
