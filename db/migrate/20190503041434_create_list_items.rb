class CreateListItems < ActiveRecord::Migration[5.0]
  def up
    drop_table "activ_notifications" if ActiveRecord::Base.connection.table_exists?("activ_notifications")
    drop_table "activ_subscriptions" if ActiveRecord::Base.connection.table_exists?("activ_subscriptions")
    drop_table "aliases" if ActiveRecord::Base.connection.table_exists?("aliases")
    drop_table "answers" if ActiveRecord::Base.connection.table_exists?("answers")
    drop_table "authentications" if ActiveRecord::Base.connection.table_exists?("authentications")
    drop_table "banned_tags" if ActiveRecord::Base.connection.table_exists?("banned_tags")
    drop_table "channels_referents" if ActiveRecord::Base.connection.table_exists?("channels_referents")
    drop_table "deferred_requests" if ActiveRecord::Base.connection.table_exists?("deferred_requests")
    drop_table "delayed_jobs" if ActiveRecord::Base.connection.table_exists?("delayed_jobs")
    drop_table "editions" if ActiveRecord::Base.connection.table_exists?("editions")
    drop_table "event_notices" if ActiveRecord::Base.connection.table_exists?("event_notices")
    drop_table "expressions" if ActiveRecord::Base.connection.table_exists?("expressions")
    drop_table "feed_entries" if ActiveRecord::Base.connection.table_exists?("feed_entries")
    drop_table "feedbacks" if ActiveRecord::Base.connection.table_exists?("feedbacks")
    drop_table "feeds" if ActiveRecord::Base.connection.table_exists?("feeds")
    drop_table "finders" if ActiveRecord::Base.connection.table_exists?("finders")
    drop_table "gleanings" if ActiveRecord::Base.connection.table_exists?("gleanings")
    drop_table "image_references" if ActiveRecord::Base.connection.table_exists?("image_references")
    drop_table "letsencrypt_plugin_challenges" if ActiveRecord::Base.connection.table_exists?("letsencrypt_plugin_challenges")
    drop_table "lists" if ActiveRecord::Base.connection.table_exists?("lists")
    drop_table "lists_tags" if ActiveRecord::Base.connection.table_exists?("lists_tags")
    drop_table "notifications" if ActiveRecord::Base.connection.table_exists?("notifications")
    drop_table "offerings" if ActiveRecord::Base.connection.table_exists?("offerings")
    drop_table "page_refs" if ActiveRecord::Base.connection.table_exists?("page_refs")
    drop_table "private_subscriptions" if ActiveRecord::Base.connection.table_exists?("private_subscriptions")
    drop_table "products" if ActiveRecord::Base.connection.table_exists?("products")
    drop_table "ratings" if ActiveRecord::Base.connection.table_exists?("ratings")
    drop_table "rcprefs" if ActiveRecord::Base.connection.table_exists?("rcprefs")
    drop_table "recipes" if ActiveRecord::Base.connection.table_exists?("recipes")
    drop_table "referent_relations" if ActiveRecord::Base.connection.table_exists?("referent_relations")
    drop_table "referents" if ActiveRecord::Base.connection.table_exists?("referents")
    drop_table "referments" if ActiveRecord::Base.connection.table_exists?("referments")
    drop_table "results_caches" if ActiveRecord::Base.connection.table_exists?("results_caches")
    drop_table "rp_events" if ActiveRecord::Base.connection.table_exists?("rp_events")
    drop_table "scales" if ActiveRecord::Base.connection.table_exists?("scales")
    drop_table "scrapers" if ActiveRecord::Base.connection.table_exists?("scrapers")
    drop_table "sites" if ActiveRecord::Base.connection.table_exists?("sites")
    drop_table "subscriptions" if ActiveRecord::Base.connection.table_exists?("subscriptions")
    drop_table "suggestions" if ActiveRecord::Base.connection.table_exists?("suggestions")
    drop_table "tag_owners" if ActiveRecord::Base.connection.table_exists?("tag_owners")
    drop_table "tag_selections" if ActiveRecord::Base.connection.table_exists?("tag_selections")
    drop_table "taggings" if ActiveRecord::Base.connection.table_exists?("taggings")
    drop_table "tags" if ActiveRecord::Base.connection.table_exists?("tags")
    drop_table "tags_caches" if ActiveRecord::Base.connection.table_exists?("tags_caches")
    drop_table "tagsets" if ActiveRecord::Base.connection.table_exists?("tagsets")
    drop_table "users" if ActiveRecord::Base.connection.table_exists?("users")
    drop_table "visitors" if ActiveRecord::Base.connection.table_exists?("visitors")
    drop_table "votes" if ActiveRecord::Base.connection.table_exists?("votes")
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
