module ListItemsHelper

  def item_status item
    safe_join [
        ((item.onHold ? 'On' : 'Not On') + ' Hold'),
        (item.doneDate ? "Done #{item.doneDate}" : "Not Done"),
        (item.suggested ? 'Already' : 'Not Already') + ' Suggested'
    ], tag(:br)
  end
end
