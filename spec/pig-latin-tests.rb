require 'test/unit'
require_relative '../pig-latin'

class TestPigLatin < Test::Unit::TestCase
  include PigLatin

  def test_single_strings_single_consonants_capital
    assert_equal pig_latinify('Pig'), 'Igpay'
  end

  def test_single_strings_single_consonants_lowercase
    assert_equal pig_latinify('pig'), 'igpay'
  end

  def test_single_strings_multiple_consonants_lowercase
    assert_equal pig_latinify('blam'), 'amblay'
    assert_equal pig_latinify('great'), 'eatgray'
  end

  def test_single_strings_multiple_consonants_uppercase
    assert_equal pig_latinify('Blam'), 'Amblay'
    assert_equal pig_latinify('Great'), 'Eatgray'
  end

  def test_single_strings_vowels
    assert_equal pig_latinify('Amazing'), 'Amazingway'
    assert_equal pig_latinify('eeore'), 'eeoreway'
    assert_equal pig_latinify('Isaac'), 'Isaacway'
    assert_equal pig_latinify('yum'), 'yumway' # y considered vowel
  end

  def test_single_strings_not_normal_words
    assert_equal pig_latinify('e-mail'), 'e-mailway'
  end

  def test_sentences_no_punctuation
    assert_equal pig_latinify('i love pigs so much'), 'iway ovelay igspay osay uchmay'
    assert_equal pig_latinify('She sells sea shells by the sea shore'), 'Eshay ellssay easay ellsshay ybay ethay easay oreshay'
  end

  def test_sentences_with_punctuation
    assert_equal pig_latinify('i love pigs so much!!!!'), 'iway ovelay igspay osay uchmay!!!!'
    assert_equal pig_latinify('wow. Pigs rock!'), 'owway. Igspay ockray!'
  end
end
