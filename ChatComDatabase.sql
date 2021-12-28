CREATE TABLE `android_metadata` (
  `locale` TEXT
);

CREATE TABLE `message` (
  `_id` integer,
  `id` text UNIQUE,
  `conversation_id` text NOT NULL,
  `sender_id` text,
  `sender_name` text,
  `recipient_id` text NOT NULL,
  `created_timestamp` int NOT NULL,
  `modified_timestamp` int NOT NULL,
  `status` text NOT NULL,
  `is_masked` int NOT NULL,
  `payload` text NOT NULL,
  `reply_to_id` text,
  `is_reply_allowed` boolean NOT NULL,
  `is_forwarded` boolean NOT NULL,
  `is_forwarding_allowed` boolean NOT NULL,
  `send_error_type` string,
  `sender_avatar_url` text,
  `is_incoming` boolean NOT NULL,
  `payload_type` text NOT NULL,
  `is_liked` int NOT NULL,
  `is_like_allowed` int NOT NULL,
  `is_likely_offensive` boolean NOT NULL,
  PRIMARY KEY (`_id`)
);

CREATE TABLE `sending_info` (
  `_id` integer,
  `chat_block_id` integer,
  `request_message_id` text,
  `stream_id` text,
  `opener_id` text,
  `location_source` integer,
  `forward_message_id` text,
  `forward_source_id` text,
  `forward_target_id` text,
  `sending_type` text NOT NULL,
  `sending_mode` text NOT NULL,
  `is_front_camera` integer,
  `is_source_camera` integer,
  `duration_ms` integer,
  PRIMARY KEY (`_id`)
);

CREATE TABLE `conversation_info` (
  `user_id` text,
  `gender` integer,
  `user_name` text,
  `user_image_url` text,
  `user_deleted` boolean,
  `max_unanswered_messages` integer,
  `sending_multimedia_enabled` integer,
  `disabled_multimedia_explanation` text,
  `multimedia_visibility_options` text,
  `enlarged_emojis_max_count` integer,
  `photo_url` text,
  `age` integer NOT NULL,
  `is_inapp_promo_partner` boolean,
  `game_mode` integer,
  `match_status` text,
  `chat_theme_settings` text,
  `chat_input_settings` text NOT NULL,
  `is_open_profile_enabled` boolean,
  `conversation_type` text NOT NULL,
  `extra_message` text,
  `user_photos` text NOT NULL,
  `photo_id` text,
  `work` text,
  `education` text,
  `photo_count` integer NOT NULL,
  `common_interest_count` integer NOT NULL,
  `bumped_into_count` integer NOT NULL,
  `is_liked_you` boolean NOT NULL,
  `forwarding_settings` text,
  `is_reply_allowed` boolean NOT NULL,
  `live_location_settings` text,
  `is_disable_private_detector_enabled` boolean NOT NULL,
  `member_count` integer,
  `is_url_parsing_allowed` boolean NOT NULL,
  `is_user_verified` boolean NOT NULL,
  `last_message_status` text,
  `encrypted_user_id` text,
  `covid_preferences` text,
  `mood_status_emoji` text,
  `mood_status_name` text,
  `show_dating_hub_entry_point` boolean NOT NULL,
  `hive_id` text,
  `hive_pending_join_request_count` integer,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `message_read_info` (
  `user_id` text,
  `outgoing_read_timestamp` integer NOT NULL,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `offline_message_read_info` (
  `conversation_id` text,
  `encrypted_conversation_id` text NOT NULL,
  `conversation_type` text NOT NULL,
  `offline_read_timestamp` integer NOT NULL,
  PRIMARY KEY (`conversation_id`)
);

CREATE TABLE `url_preview` (
  `url` text,
  `title` text,
  `description` text,
  `image` text,
  PRIMARY KEY (`url`)
);

CREATE TABLE `search_fts` (
  `payload` TEXT
);

CREATE TABLE `search_fts_content` (
  `docid` INTEGER,
  `c0payload` TEXT,
  PRIMARY KEY (`docid`)
);

CREATE TABLE `search_fts_segments` (
  `blockid` INTEGER,
  `block` BLOB,
  PRIMARY KEY (`blockid`)
);

CREATE TABLE `search_fts_segdir` (
  `level` INTEGER,
  `idx` INTEGER,
  `start_block` INTEGER,
  `leaves_end_block` INTEGER,
  `end_block` INTEGER,
  `root` BLOB,
  PRIMARY KEY (`level`, `idx`)
);

CREATE TABLE `search_fts_docsize` (
  `docid` INTEGER,
  `size` BLOB,
  PRIMARY KEY (`docid`)
);

CREATE TABLE `search_fts_stat` (
  `id` INTEGER,
  `value` BLOB,
  PRIMARY KEY (`id`)
);

CREATE TABLE `gif` (
  `cacheKey` text,
  `giphyResult` text,
  `lastUsed` integer,
  PRIMARY KEY (`cacheKey`)
);

CREATE TABLE `live_location_sessions` (
  `id` text,
  `conversation_id` text NOT NULL,
  `message_id` integer NOT NULL,
  `expiration` integer NOT NULL,
  `last_update` integer NOT NULL,
  `min_interval_sec` integer NOT NULL,
  `min_distance_meters` integer NOT NULL,
  `is_stop_requested` boolean NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `group_chat_sync_state` (
  `conversation_id` text,
  `sync_token` text NOT NULL,
  `page_token` text,
  `is_preloading_finished` integer NOT NULL,
  `preloaded_message_count` integer NOT NULL,
  PRIMARY KEY (`conversation_id`)
);

CREATE TABLE `group_chat_preload_queue` (
  `_id` integer,
  `conversation_id` text UNIQUE NOT NULL,
  PRIMARY KEY (`_id`)
);

CREATE TABLE `sqlite_sequence` (
  `name` text,
  `seq` integer
);

ALTER TABLE `message` ADD FOREIGN KEY (`conversation_id`) REFERENCES `conversation_info` (`user_id`);

ALTER TABLE `message_read_info` ADD FOREIGN KEY (`user_id`) REFERENCES `conversation_info` (`encrypted_user_id`);

ALTER TABLE `offline_message_read_info` ADD FOREIGN KEY (`conversation_id`) REFERENCES `conversation_info` (`user_id`);

ALTER TABLE `group_chat_sync_state` ADD FOREIGN KEY (`conversation_id`) REFERENCES `conversation_info` (`user_id`);

ALTER TABLE `search_fts_docsize` ADD FOREIGN KEY (`docid`) REFERENCES `search_fts_content` (`docid`);

ALTER TABLE `group_chat_preload_queue` ADD FOREIGN KEY (`conversation_id`) REFERENCES `group_chat_sync_state` (`conversation_id`);

ALTER TABLE `live_location_sessions` ADD FOREIGN KEY (`conversation_id`) REFERENCES `conversation_info` (`user_id`);

ALTER TABLE `live_location_sessions` ADD FOREIGN KEY (`message_id`) REFERENCES `message` (`id`);

ALTER TABLE `search_fts` ADD FOREIGN KEY (`payload`) REFERENCES `search_fts_content` (`c0payload`);

