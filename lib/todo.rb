class TodoItem
  include Listable
  include UdaciListErrors
  attr_reader :description, :due, :priority, :type

  def initialize(description, type, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    unless ["high", "medium", "low", nil].include? options[:priority]
      raise InvalidPriorityValue, "Priority value is invalid!"
    end
    @priority = options[:priority]
    @type = "todo"
  end
  def details
    format_type +
    format_description(@description) +
    "due: " + format_date(due: due) +
    format_priority(@priority)
  end
  def set_priority (priority)
    unless ["high", "medium", "low", nil].include? priority
      raise InvalidPriorityValue, "Priority value is invalid!"
    end
    @priority = priority
  end
end
