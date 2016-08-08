module Listable
  # Listable methods go here
  def format_description(description)
    "#{@description}".ljust(30)
  end
  def format_priority(priority)
    value = " ⇧".colorize(:red) if @priority == "high"
    value = " ⇨".colorize(:yellow) if @priority == "medium"
    value = " ⇩".colorize(:green) if @priority == "low"
    value = "" if !@priority
    return value
  end
  def format_date(options={})
  	if options[:start_date] and options[:end_date]
 	    dates = @start_date.strftime("%D") if @start_date
 	    dates << " -- " + @end_date.strftime("%D") if @end_date
 	    dates = "N/A" if !dates
 	    return dates
 	else
 		@due ? @due.strftime("%D") : "No due date"
 	end
  end
end
