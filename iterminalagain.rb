require 'terminfo'

class Presentation
  def initialize(slides_file)
    @array_of_texts = FileReader.new(slides_file).get_slides_text
  end

  def display_slides
    half_screen_height = TermInfo.screen_height / 2
    half_screen_width  = TermInfo.screen_width  / 2
    @array_of_texts.each do |text|
      puts "\n" * half_screen_height
      puts (" " * (half_screen_width - text.length / 2)) + text
      puts "\n" * (half_screen_height - 1)
    end
  end
end

class FileReader
  def initialize(slides_file)
    @slides_file = slides_file
  end

  def get_slides_text
    IO.read(@slides_file).split("----\n").map(&:chomp)
  end
end

Presentation.new("terminal_slideshow.txt").display_slides
