json.extract! list_item, :id, :title, :description, :onHold, :list_type_id, :doneDate, :link, :suggested
json.url list_item_url(list_item, format: :json)
