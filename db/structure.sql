CREATE TABLE "accesstokens" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" varchar(255), "type" varchar(255), "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "assignments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "logpage_id" integer, "tag_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" text, "location_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "continents" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "countries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "continent_id" integer);
CREATE TABLE "friendships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "friend_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "galleries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "location_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "locations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "subtitle" varchar(255), "latitude" float, "longitude" float, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "country_id" integer);
CREATE TABLE "logbooks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" text, "location_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "logpages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "content" text, "logbook_id" integer, "category_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "password" varchar(255), "first_name" varchar(255), "last_name" varchar(255), "birth" date, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "sex" varchar(255));
CREATE INDEX "index_assignments_on_logpage_id" ON "assignments" ("logpage_id");
CREATE INDEX "index_assignments_on_tag_id" ON "assignments" ("tag_id");
CREATE INDEX "index_friendships_on_friend_id" ON "friendships" ("friend_id");
CREATE INDEX "index_friendships_on_user_id" ON "friendships" ("user_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120629082352');

INSERT INTO schema_migrations (version) VALUES ('20120629084659');

INSERT INTO schema_migrations (version) VALUES ('20120629095328');

INSERT INTO schema_migrations (version) VALUES ('20120701153542');

INSERT INTO schema_migrations (version) VALUES ('20120701160205');

INSERT INTO schema_migrations (version) VALUES ('20120701160237');

INSERT INTO schema_migrations (version) VALUES ('20120702115721');

INSERT INTO schema_migrations (version) VALUES ('20120702121553');

INSERT INTO schema_migrations (version) VALUES ('20120702122324');

INSERT INTO schema_migrations (version) VALUES ('20120702122905');

INSERT INTO schema_migrations (version) VALUES ('20120702122951');

INSERT INTO schema_migrations (version) VALUES ('20120702123348');

INSERT INTO schema_migrations (version) VALUES ('20120702140309');

INSERT INTO schema_migrations (version) VALUES ('20120703132934');

INSERT INTO schema_migrations (version) VALUES ('20120703133237');

INSERT INTO schema_migrations (version) VALUES ('20120703143429');