class CreateListItems < ActiveRecord::Migration[5.0]
  def up
	drop_table "activ_notifications"
	drop_table "activ_subscriptions"
	drop_table "aliases"
	drop_table "answers"
	drop_table "authentications"
	drop_table "banned_tags"
	drop_table "channels_referents"
	drop_table "deferred_requests"
	drop_table "delayed_jobs"
	drop_table "editions"
	drop_table "event_notices"
	drop_table "expressions"
	drop_table "feed_entries"
	drop_table "feedbacks"
	drop_table "feeds"
	drop_table "finders"
	drop_table "gleanings"
	drop_table "image_references"
	drop_table "letsencrypt_plugin_challenges"
	drop_table "lists"
	drop_table "lists_tags"
	drop_table "notifications"
	drop_table "offerings"
	drop_table "page_refs"
	drop_table "private_subscriptions"
	drop_table "products"
	drop_table "ratings"
	drop_table "rcprefs"
	drop_table "recipes"
	drop_table "referent_relations"
	drop_table "referents"
	drop_table "referments"
	drop_table "results_caches"
	drop_table "rp_events"
	drop_table "scales"
	drop_table "scrapers"
	drop_table "sites"
	drop_table "subscriptions"
	drop_table "suggestions"
	drop_table "tag_owners"
	drop_table "tag_selections"
	drop_table "taggings"
	drop_table "tags"
	drop_table "tags_caches"
	drop_table "tagsets"
	drop_table "users"
	drop_table "visitors"
	drop_table "votes"
    drop_table :list_items if ActiveRecord::Base.connection.table_exists?("list_items")
     create_table :list_items do |t|
      t.belongs_to :user
      t.belongs_to :list
      t.text :title
      t.text :description
      t.boolean :onHold
      t.date :doneDate
      t.text :link
      t.boolean :suggested

      t.timestamps
    end
  end
  def down
    drop_table :list_items 
  end
end
