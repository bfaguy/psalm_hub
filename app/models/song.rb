class Song < ActiveRecord::Base
  def number_of_lines
    if lyrics.present?
      split_lyrics.count
    else
      0
    end
  end

  def display_chords
    if chords.present?
      chords
    else
      ""
    end
  end

  def display_lyrics
    if lyrics.present?
      split_lyrics
    else
      ""
    end
  end

  def split_lyrics
    self.lyrics.split(/\r?\n/)
  end
end
