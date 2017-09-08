class Banner
  def initialize(message, banner_width = nil)
    @message = message
    @banner_width = banner_width ? banner_width : message.size
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{"-" * @banner_width}-+"

  end

  def empty_line
    "| #{" " * @banner_width} |"
  end

  def message_line
    "| " + @message[0, @banner_width].center(@banner_width) + " |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
banner = Banner.new('')
puts banner
banner = Banner.new('To boldly go where no one has gone before.', 80)
puts banner
banner = Banner.new('Test Width', 6)
puts banner