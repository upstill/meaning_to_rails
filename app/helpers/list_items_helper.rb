module ListItemsHelper

  def item_status item
    safe_join [
        ('On Hold' if item.onHold),
        ("Done #{item.doneDate}" if item.doneDate),
        ('Suggested' if item.suggested)
    ].compact, tag(:br)
  end
end
