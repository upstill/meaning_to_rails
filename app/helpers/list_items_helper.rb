module ListItemsHelper

  def item_status item
    [
        ((item.onHold ? '' : 'Not') + ' on Hold'),
        (item.doneDate ? "Done #{item.doneDate}" : "Not Done"),
        (item.suggested ? '' : 'Not') + ' already Suggested'
    ].join(', ') + '.'
  end
end
