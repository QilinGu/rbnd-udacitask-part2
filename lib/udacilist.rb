class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]|| "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    validate_type(type)
    @items.push TodoItem.new(description, type, options) if type == "todo"
    @items.push EventItem.new(description, type, options) if type == "event"
    @items.push LinkItem.new(description, type, options) if type == "link"
  end
  def delete(index)
    validate_index(index)
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
  def filter(type)
    validate_type(type)
    filtered_items = @items.select {|i| i.type == type}
    puts ("-" * (@title.length + 10)).colorize(:light_yellow)
    puts ("#{@title}'s" + " #{type}s").colorize(:magenta)
    puts ("-" * (@title.length + 10)).colorize(:light_yellow)
    if filtered_items.length == 0
      puts "No #{type}s found in this list."
    else
      filtered_items.each_with_index do |item, position|
        puts "#{position + 1}) #{item.details}"
      end
    end
  end

  def table_output
    rows = []
    @items.each_with_index do |item, position|
      rows << ["_", position + 1, item.details]
    end
    puts Terminal::Table.new(title: @title.colorize(:light_yellow), rows: rows)
  end
  def multi_delete(item_indexes)
    counter = 0
    item_indexes.sort!
    item_indexes.each do |index|
      updated_index = index- counter - 1
      validate_index(updated_index)
      @items.delete_at(updated_index)
      counter += 1
    end
  end
  def priority(index, priority)
    validate_index(index)
    raise InvalidItemType, "Only todos have priority!" unless @items[index - 1].type == 'todo'
    @items[index - 1].set_priority(priority)
  end
  def validate_index(index)
    raise IndexExceedsListSize, "Index #{index} exceeds the list length" if index >= @items.length
  end
  def validate_type(type)
    raise InvalidItemType, "Item type is invalid!" unless type == "todo" or type == "event" or type == "link"
  end
end
