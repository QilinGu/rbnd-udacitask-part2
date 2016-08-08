class TodoItem
  include Listable
  include UdaciListErrors
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    unless ["high", "medium", "low", nil].include? options[:priority]
      raise InvalidPriorityValue, "Priority value is invalid!"
    end
    @priority = options[:priority]
    @type = "todo"
  end
  def details
    format_description(@description) + "due: " +
    format_date(due: due) +
    format_priority(@priority)
  end
end
