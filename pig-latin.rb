require 'set'

module PigLatin
  PUNCTUATION = Set.new ['!', '?', '.', ',', ':', ';']
  VOWELS = Set.new ['a', 'e', 'i', 'o', 'u', 'y', 'A', 'E', 'I', 'O', 'U', 'Y']
  VOWEL_REGEX = /a|e|i|o|u|y|A|E|I|O|U|Y/


  def split_punctuation(str)
    for idx in (0...str.length)
      if PUNCTUATION.include?(str[idx])
        return [str[0...idx], str[idx..-1]]
      end
    end
    false
  end

  def pig_latinify_single_word(str)
    punc_res = split_punctuation(str)
    return pig_latinify_base_word(str) unless punc_res
    base_str, punctuation = punc_res
    pig_latinify_base_word(base_str) + punctuation
  end

  def pig_latinify(str)
    all_words = str.split
    all_words.map {|w| pig_latinify_single_word(w) }.join(' ')
  end

  private

  def pig_latinify_base_word(single_word)
    vowel_idx = get_first_vowel_idx(single_word)
    if vowel_idx && vowel_idx == 0
      pig_latinify_base_vowel(single_word)
    else
      pig_latinify_base_consonant(single_word, vowel_idx)
    end
  end

  def pig_latinify_base_consonant(base_str, idx_to_split)
    # Ignores punctuation. Used internally only.
    first_string_capital = base_str[0] == base_str[0].upcase
    return move_first_chars_to_end(base_str, idx_to_split) + 'ay' unless first_string_capital
    res = move_first_chars_to_end(base_str[0].downcase + base_str[1..-1], idx_to_split)
    res[0].upcase + res[1..-1] + 'ay'
  end

  def pig_latinify_base_vowel(base_str)
    return base_str + 'way'
  end

  def get_first_vowel_idx(str)
    str.index(VOWEL_REGEX)
  end

  def move_first_chars_to_end(str, first_vowel_idx)
    str[first_vowel_idx..-1] + str[0...first_vowel_idx]
  end
end
