require 'terminfo'

class Presentation
  def initialize(slides_file)
    @array_of_texts = FileReader.new(slides_file).get_slides_text
    @half_screen_height = TermInfo.screen_height / 2
    @half_screen_width  = TermInfo.screen_width  / 2
    @current_slide_position = 0
  end

  def display_slides
    print_current_slide
    get_user_input
  end

  private
  def print_current_slide
    text = @array_of_texts[@current_slide_position]
    puts "\n" * @half_screen_height
    puts (" " * (@half_screen_width - text.length / 2)) + text
    puts "\n" * (@half_screen_height - 1)
    print "> "
  end

  def get_user_input
    input = gets.chomp
    case input.downcase
    when "next"
      @current_slide_position += 1
    when "previous"
      @current_slide_position -= 1
    when "quit"
      return
    end
    display_slides
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
