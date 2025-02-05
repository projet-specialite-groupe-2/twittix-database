CREATE TABLE "follows" (
  "following_user_id" integer NOT NULL,
  "followed_user_id" integer NOT NULL,
  "is_accepted" bool DEFAULT false,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "blocked" (
  "blocking_user_id" integer NOT NULL,
  "blocked_user_id" integer NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "role" varchar NOT NULL,
  "username" varchar UNIQUE NOT NULL,
  "description" longtext,
  "birthdate" DATE NOT NULL,
  "picture" varchar,
  "is_private" bool DEFAULT false,
  "is_active" bool DEFAULT true,
  "is_ban" bool DEFAULT false,
  "deleted_at" timestamp,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "content" varchar,
  "user_id" integer NOT NULL,
  "status" varchar,
  "parent" integer,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "likes" (
  "liking_user_id" integer NOT NULL,
  "liked_post_id" integer NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "reposts" (
  "reposting_user_id" integer NOT NULL,
  "reposted_post_id" integer NOT NULL,
  "comment" varchar,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "mentions" (
  "mentioning_post_id" integer NOT NULL,
  "mentioned_user_id" integer NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "conversations" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "picture" varchar,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "conversation_users" (
  "conversation" integer NOT NULL,
  "user" integer NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "messages" (
  "conversation" integer NOT NULL,
  "user" integer NOT NULL,
  "content" varchar,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "reports" (
  "id" integer PRIMARY KEY,
  "reporting_user_id" integer NOT NULL,
  "reported_user_id" integer,
  "reported_post_id" integer,
  "type" integer NOT NULL,
  "message" varchar,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "report_types" (
  "id" integer PRIMARY KEY,
  "label" varchar NOT NULL,
  "name" varchar
);

CREATE TABLE "post_view_status" (
  "user" integer NOT NULL,
  "post" integer NOT NULL,
  "readt_at" timestamp NOT NULL
);

COMMENT ON COLUMN "users"."picture" IS 'url';

COMMENT ON COLUMN "posts"."content" IS 'Content of the post';

COMMENT ON COLUMN "reposts"."comment" IS 'Comment of the post';

ALTER TABLE "follows" ADD FOREIGN KEY ("following_user_id") REFERENCES "users" ("id");

ALTER TABLE "follows" ADD FOREIGN KEY ("followed_user_id") REFERENCES "users" ("id");

ALTER TABLE "blocked" ADD FOREIGN KEY ("blocking_user_id") REFERENCES "users" ("id");

ALTER TABLE "blocked" ADD FOREIGN KEY ("blocked_user_id") REFERENCES "users" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("liking_user_id") REFERENCES "users" ("id");

ALTER TABLE "reports" ADD FOREIGN KEY ("reporting_user_id") REFERENCES "users" ("id");

ALTER TABLE "reports" ADD FOREIGN KEY ("reported_user_id") REFERENCES "users" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("id") REFERENCES "reposts" ("reposting_user_id");

ALTER TABLE "posts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("liked_post_id") REFERENCES "posts" ("id");

ALTER TABLE "reports" ADD FOREIGN KEY ("reported_post_id") REFERENCES "posts" ("id");

ALTER TABLE "reposts" ADD FOREIGN KEY ("reposted_post_id") REFERENCES "posts" ("id");

ALTER TABLE "conversation_users" ADD FOREIGN KEY ("user") REFERENCES "users" ("id");

ALTER TABLE "conversation_users" ADD FOREIGN KEY ("conversation") REFERENCES "conversations" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("conversation") REFERENCES "conversations" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("user") REFERENCES "users" ("id");

ALTER TABLE "reports" ADD FOREIGN KEY ("type") REFERENCES "report_types" ("id");

ALTER TABLE "mentions" ADD FOREIGN KEY ("mentioning_post_id") REFERENCES "posts" ("id");

ALTER TABLE "mentions" ADD FOREIGN KEY ("mentioned_user_id") REFERENCES "users" ("id");

ALTER TABLE "post_view_status" ADD FOREIGN KEY ("user") REFERENCES "users" ("id");

ALTER TABLE "post_view_status" ADD FOREIGN KEY ("post") REFERENCES "posts" ("id");
