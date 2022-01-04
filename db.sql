BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "posts_category" (
	"id"	integer NOT NULL,
	"title"	varchar(20) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "posts_post_categories" (
	"id"	integer NOT NULL,
	"post_id"	integer NOT NULL,
	"category_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("post_id") REFERENCES "posts_post"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("category_id") REFERENCES "posts_category"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "posts_post_dislikes" (
	"id"	integer NOT NULL,
	"post_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("post_id") REFERENCES "posts_post"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "posts_post_likes" (
	"id"	integer NOT NULL,
	"post_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("post_id") REFERENCES "posts_post"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "posts_comment" (
	"id"	integer NOT NULL,
	"content"	text NOT NULL,
	"date"	datetime NOT NULL,
	"image"	varchar(100) NOT NULL,
	"parent_id"	integer,
	"post_id"	integer NOT NULL,
	"user_id"	integer,
	FOREIGN KEY("parent_id") REFERENCES "posts_comment"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("post_id") REFERENCES "posts_post"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "posts_comment_dislikes" (
	"id"	integer NOT NULL,
	"comment_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("comment_id") REFERENCES "posts_comment"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "posts_comment_likes" (
	"id"	integer NOT NULL,
	"comment_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	FOREIGN KEY("comment_id") REFERENCES "posts_comment"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "users_profile" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	"image"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "posts_report" (
	"id"	integer NOT NULL,
	"post_id"	integer NOT NULL,
	"user_id"	integer,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("post_id") REFERENCES "posts_post"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "posts_post" (
	"id"	integer NOT NULL,
	"title"	varchar(90) NOT NULL,
	"post_id"	varchar(7) NOT NULL UNIQUE,
	"date"	datetime NOT NULL,
	"comment_cnt"	integer NOT NULL,
	"image"	varchar(100),
	"author_id"	integer NOT NULL,
	"video"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("author_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2020-12-15 22:07:03.370785');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2020-12-15 22:07:03.391913');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2020-12-15 22:07:03.406672');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2020-12-15 22:07:03.422324');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2020-12-15 22:07:03.439029');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2020-12-15 22:07:03.460067');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2020-12-15 22:07:03.473470');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2020-12-15 22:07:03.487488');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2020-12-15 22:07:03.501307');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2020-12-15 22:07:03.513067');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2020-12-15 22:07:03.518560');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2020-12-15 22:07:03.536689');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2020-12-15 22:07:03.547531');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2020-12-15 22:07:03.559012');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2020-12-15 22:07:03.572873');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2020-12-15 22:07:03.584891');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2020-12-15 22:07:03.597022');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2020-12-15 22:07:03.604026');
INSERT INTO "django_migrations" VALUES (19,'posts','0001_initial','2020-12-15 22:11:57.200535');
INSERT INTO "django_migrations" VALUES (20,'posts','0002_auto_20190713_0442','2020-12-15 22:11:57.232225');
INSERT INTO "django_migrations" VALUES (21,'users','0001_initial','2020-12-15 22:15:01.755096');
INSERT INTO "django_migrations" VALUES (22,'users','0002_auto_20201215_2229','2020-12-15 22:29:55.347867');
INSERT INTO "django_migrations" VALUES (23,'posts','0002_report_title','2020-12-15 22:31:56.117010');
INSERT INTO "django_migrations" VALUES (24,'posts','0003_remove_report_title','2020-12-15 22:32:53.856835');
INSERT INTO "django_migrations" VALUES (25,'posts','0004_report_author','2020-12-16 21:36:06.177666');
INSERT INTO "django_migrations" VALUES (26,'posts','0002_report_user','2020-12-16 21:39:33.071507');
INSERT INTO "django_migrations" VALUES (27,'posts','0003_post_video','2020-12-17 13:45:19.307811');
INSERT INTO "django_migrations" VALUES (28,'posts','0004_auto_20201218_1759','2020-12-18 17:59:18.800455');
INSERT INTO "django_migrations" VALUES (32,'posts','0005_auto_20201218_1802','2020-12-18 18:33:16.397051');
INSERT INTO "django_migrations" VALUES (33,'posts','0006_auto_20201218_1829','2020-12-18 18:33:16.427098');
INSERT INTO "django_migrations" VALUES (34,'posts','0007_auto_20201218_1833','2020-12-18 18:33:41.879412');
INSERT INTO "django_migrations" VALUES (35,'posts','0008_auto_20201218_1834','2020-12-18 18:34:35.954036');
INSERT INTO "django_admin_log" VALUES (1,'2020-12-18 13:45:04.829516','4','empty','',8,1,3);
INSERT INTO "django_admin_log" VALUES (2,'2020-12-18 15:02:31.944916','20','big','',8,1,3);
INSERT INTO "django_admin_log" VALUES (3,'2020-12-18 15:02:31.953058','19','loc','',8,1,3);
INSERT INTO "django_admin_log" VALUES (4,'2020-12-18 15:02:31.958368','18','big','',8,1,3);
INSERT INTO "django_admin_log" VALUES (5,'2020-12-18 15:02:31.963482','17','trandan','',8,1,3);
INSERT INTO "django_admin_log" VALUES (6,'2020-12-18 16:24:47.914859','23','800','',8,1,3);
INSERT INTO "django_admin_log" VALUES (7,'2020-12-18 16:24:47.922552','22','small','',8,1,3);
INSERT INTO "django_admin_log" VALUES (8,'2020-12-18 16:24:47.927852','21','loc','',8,1,3);
INSERT INTO "django_admin_log" VALUES (9,'2020-12-18 16:49:43.239336','28','?','',8,1,3);
INSERT INTO "django_admin_log" VALUES (10,'2020-12-18 17:21:34.819132','32','title','',8,1,3);
INSERT INTO "django_admin_log" VALUES (11,'2020-12-18 17:21:34.827072','31','title','',8,1,3);
INSERT INTO "django_admin_log" VALUES (12,'2020-12-18 17:21:34.834864','30','title','',8,1,3);
INSERT INTO "django_admin_log" VALUES (13,'2020-12-18 17:21:34.839929','29','title','',8,1,3);
INSERT INTO "django_admin_log" VALUES (14,'2020-12-18 18:12:39.763219','35','blank video','',8,1,3);
INSERT INTO "django_admin_log" VALUES (15,'2020-12-18 18:12:39.771416','34','title','',8,1,3);
INSERT INTO "django_admin_log" VALUES (16,'2020-12-18 18:12:39.776697','33','title','',8,1,3);
INSERT INTO "django_admin_log" VALUES (17,'2020-12-18 18:12:39.781848','24','cats','',8,1,3);
INSERT INTO "django_admin_log" VALUES (18,'2020-12-18 18:32:54.159223','39','?','',8,1,3);
INSERT INTO "django_admin_log" VALUES (19,'2020-12-18 21:15:27.615750','40','text new form view','[{"changed": {"fields": ["Image"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (20,'2020-12-18 21:16:35.425866','40','text new form view','[{"changed": {"fields": ["Image"]}}]',8,1,2);
INSERT INTO "django_admin_log" VALUES (21,'2020-12-18 21:21:30.372378','42','test','',8,1,3);
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'posts','category');
INSERT INTO "django_content_type" VALUES (8,'posts','post');
INSERT INTO "django_content_type" VALUES (9,'posts','comment');
INSERT INTO "django_content_type" VALUES (10,'posts','report');
INSERT INTO "django_content_type" VALUES (11,'users','profile');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_category','Can add category');
INSERT INTO "auth_permission" VALUES (26,7,'change_category','Can change category');
INSERT INTO "auth_permission" VALUES (27,7,'delete_category','Can delete category');
INSERT INTO "auth_permission" VALUES (28,7,'view_category','Can view category');
INSERT INTO "auth_permission" VALUES (29,8,'add_post','Can add post');
INSERT INTO "auth_permission" VALUES (30,8,'change_post','Can change post');
INSERT INTO "auth_permission" VALUES (31,8,'delete_post','Can delete post');
INSERT INTO "auth_permission" VALUES (32,8,'view_post','Can view post');
INSERT INTO "auth_permission" VALUES (33,9,'add_comment','Can add comment');
INSERT INTO "auth_permission" VALUES (34,9,'change_comment','Can change comment');
INSERT INTO "auth_permission" VALUES (35,9,'delete_comment','Can delete comment');
INSERT INTO "auth_permission" VALUES (36,9,'view_comment','Can view comment');
INSERT INTO "auth_permission" VALUES (37,10,'add_report','Can add report');
INSERT INTO "auth_permission" VALUES (38,10,'change_report','Can change report');
INSERT INTO "auth_permission" VALUES (39,10,'delete_report','Can delete report');
INSERT INTO "auth_permission" VALUES (40,10,'view_report','Can view report');
INSERT INTO "auth_permission" VALUES (41,11,'add_profile','Can add profile');
INSERT INTO "auth_permission" VALUES (42,11,'change_profile','Can change profile');
INSERT INTO "auth_permission" VALUES (43,11,'delete_profile','Can delete profile');
INSERT INTO "auth_permission" VALUES (44,11,'view_profile','Can view profile');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$216000$THVkS0nIkHLC$ye/cOaPh5wycXId0GBf5AOoqJi71vc8s++KABd+ZE2o=','2020-12-18 21:12:00.824628',1,'admin','','',1,1,'2020-12-18 11:30:03.470518','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$216000$mJVY7V2YtaKK$yoKS8c7QGhY747e9YPyGGslXZ6k3fj9BnuvN+RGHOpg=','2020-12-18 13:54:58.821601',0,'random','','ngtuanlong27@gmail.com',0,1,'2020-12-18 11:32:08.735344','');
INSERT INTO "django_session" VALUES ('j0c0tc9by8sslpfsi0tc0hyy50wdc52i','e30:1kqDxV:VbTj2e1CKh_5-1Hy1VrR1fvZ6MyYcheCQI7qx00rDwE','2021-01-01 11:30:05.879744');
INSERT INTO "django_session" VALUES ('ko02gyqqqpu05ym9a1sce2mrwjelo7j2','e30:1kqDxi:uVrgqMO-jZydojcg0---z9V-jmfJzIgnLQ5-lE1Y5gY','2021-01-01 11:30:18.070672');
INSERT INTO "django_session" VALUES ('zp1iryo9c8w2012jmlfybhbj8097is9p','e30:1kqDyA:BgsONsWIELbnH7kcyN5QppGLEKF9sLzFX5TxcPhgIfM','2021-01-01 11:30:46.519412');
INSERT INTO "django_session" VALUES ('xo6pcqyiqrpd1yr9v372gdhqymih42tx','e30:1kqDyN:ObZHaRjIQUzfnmOm37Dsthv4tb7_XMQVPxSJIfr63RA','2021-01-01 11:30:59.673004');
INSERT INTO "django_session" VALUES ('vk4osselopddyo8utgqoqqje0n093bpo','.eJxVjLsOAiEQAP-F2hAIywqW9n7DhV0WOTWQ3KMy_rshuULbmcm81ZT2rU77Kss0Z3VRVp1-GSV-ShsiP1K7d829bctMeiT6sKu-9Syv69H-DWpa69iycz7mGLBQDAYdRAdwJgPOBi9Yii1I3jojAp4BmUqERIEZsYhRny-7zDeH:1kqN2e:DLTi9rZc1i_IoFPxkPHVjjoK7l4lgy2l014WhINvLIo','2021-01-01 21:12:00.841374');
INSERT INTO "posts_category" VALUES (1,'Funny');
INSERT INTO "posts_category" VALUES (2,'Animals');
INSERT INTO "posts_category" VALUES (3,'Manga');
INSERT INTO "posts_category" VALUES (4,'Nature');
INSERT INTO "posts_category" VALUES (5,'Awesome');
INSERT INTO "posts_post_categories" VALUES (28,36,5);
INSERT INTO "posts_post_categories" VALUES (31,40,1);
INSERT INTO "posts_post_categories" VALUES (33,43,1);
INSERT INTO "posts_post_categories" VALUES (36,49,1);
INSERT INTO "posts_post_categories" VALUES (37,50,3);
INSERT INTO "users_profile" VALUES (1,1,'./profile_pics/Screenshot.png');
INSERT INTO "users_profile" VALUES (2,2,'./profile_pics/Screenshot.png');
INSERT INTO "posts_post" VALUES (36,'null check','RCYjdkP','2020-12-18 18:10:52.801356',0,'test3_hdHSO21.png',1,'');
INSERT INTO "posts_post" VALUES (37,'test video NONE on saving','yb83lP5','2020-12-18 18:23:28.594518',0,'109758874_298270901226440_7921000697148699480_n.jpg',1,'');
INSERT INTO "posts_post" VALUES (38,'test None for vid','Z2KUspP','2020-12-18 18:30:36.195419',0,'109758874_298270901226440_7921000697148699480_n_lgu7Urp.jpg',1,'');
INSERT INTO "posts_post" VALUES (40,'text new form view','9Hr2qgT','2020-12-18 21:17:01.384128',0,'IMG_1429_mIHZSjw.JPG',1,'');
INSERT INTO "posts_post" VALUES (43,'test','X30fEoa','2020-12-18 21:21:02.004071',0,'IMG_1445.JPG',1,'');
INSERT INTO "posts_post" VALUES (46,'?','T98Ntcq','2020-12-18 21:33:44.543074',0,'',1,'aK7GjNO_460sv.mp4');
INSERT INTO "posts_post" VALUES (47,'?','OPu36Wr','2020-12-18 21:35:11.616101',0,'',1,'aK7GjNO_460sv_FPeJowK.mp4');
INSERT INTO "posts_post" VALUES (48,'?','wlua40U','2020-12-18 21:36:22.288129',0,'',1,'aK7GjNO_460sv_uA4H1jn.mp4');
INSERT INTO "posts_post" VALUES (49,'?','J7921VK','2020-12-18 21:37:12.979098',0,'',1,'aK7GjNO_460sv_yVmmNTq.mp4');
INSERT INTO "posts_post" VALUES (50,'kaboom','DUqmpKm','2020-12-18 22:15:56.842368',0,'',1,'avzWgYE_460sv.mp4');
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE UNIQUE INDEX IF NOT EXISTS "posts_post_categories_post_id_category_id_00bce8d0_uniq" ON "posts_post_categories" (
	"post_id",
	"category_id"
);
CREATE INDEX IF NOT EXISTS "posts_post_categories_post_id_0ca7af15" ON "posts_post_categories" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "posts_post_categories_category_id_159f5c54" ON "posts_post_categories" (
	"category_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "posts_post_dislikes_post_id_user_id_0b4c77bb_uniq" ON "posts_post_dislikes" (
	"post_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "posts_post_dislikes_post_id_0b9b40b1" ON "posts_post_dislikes" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "posts_post_dislikes_user_id_28a2a9cb" ON "posts_post_dislikes" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "posts_post_likes_post_id_user_id_04f4f5df_uniq" ON "posts_post_likes" (
	"post_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "posts_post_likes_post_id_7f646a71" ON "posts_post_likes" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "posts_post_likes_user_id_34340602" ON "posts_post_likes" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "posts_comment_parent_id_ae76dcba" ON "posts_comment" (
	"parent_id"
);
CREATE INDEX IF NOT EXISTS "posts_comment_post_id_e81436d7" ON "posts_comment" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "posts_comment_user_id_ad949c47" ON "posts_comment" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "posts_comment_dislikes_comment_id_user_id_0af6c4d4_uniq" ON "posts_comment_dislikes" (
	"comment_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "posts_comment_dislikes_comment_id_a581289f" ON "posts_comment_dislikes" (
	"comment_id"
);
CREATE INDEX IF NOT EXISTS "posts_comment_dislikes_user_id_ed442c60" ON "posts_comment_dislikes" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "posts_comment_likes_comment_id_user_id_5d31c486_uniq" ON "posts_comment_likes" (
	"comment_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "posts_comment_likes_comment_id_04637dd5" ON "posts_comment_likes" (
	"comment_id"
);
CREATE INDEX IF NOT EXISTS "posts_comment_likes_user_id_dae52f0e" ON "posts_comment_likes" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "posts_report_post_id_bf83bdb4" ON "posts_report" (
	"post_id"
);
CREATE INDEX IF NOT EXISTS "posts_report_user_id_2bc8d930" ON "posts_report" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "posts_post_author_id_fe5487bf" ON "posts_post" (
	"author_id"
);
COMMIT;
