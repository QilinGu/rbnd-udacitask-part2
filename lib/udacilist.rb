class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]|| "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    raise InvalidItemType, "Item type is invalid!" unless type == "todo" or type == "event" or type == "link"
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
    raise IndexExceedsListSize, "Index #{index} exceeds the list length" if index >= @items.length
    @items.delete_at(index - 1)
  end
  def all
    puts ("-" * @title.length).colorize(:magenta)
    puts @title.colorize(:light_yellow)
    puts ("-" * @title.length).colorize(:magenta)
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
