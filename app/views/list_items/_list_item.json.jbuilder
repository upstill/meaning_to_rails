json.extract! list_item, :id, :user_id, :title, :description, :onHold, :listCode, :doneDate, :link, :suggested, :created_at, :updated_at
json.url list_item_url(list_item, format: :json)
