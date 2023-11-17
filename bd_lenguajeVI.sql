CREATE SEQUENCE "public".comments_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".shared_topics_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".themes_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".themes_properties_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".topics_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".users_id_seq START WITH 1 INCREMENT BY 1;

CREATE  TABLE "public".users ( 
	id                   integer DEFAULT nextval('users_id_seq'::regclass) NOT NULL  ,
	name                 varchar    ,
	last_name            varchar    ,
	avatar               varchar    ,
	email                varchar    ,
	"password"           varchar    ,
	deleted              boolean    ,
	token                varchar    ,
	CONSTRAINT users_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".themes ( 
	id                   integer DEFAULT nextval('themes_id_seq'::regclass) NOT NULL  ,
	create_date          timestamp    ,
	name                 varchar    ,
	description          varchar    ,
	keywords             varchar    ,
	owner_user_id        integer    ,
	CONSTRAINT themes_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".themes_properties ( 
	id                   integer DEFAULT nextval('themes_properties_id_seq'::regclass) NOT NULL  ,
	theme_id             integer    ,
	property_name        varchar    ,
	property_value       varchar    ,
	CONSTRAINT themes_properties_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".topics ( 
	id                   integer DEFAULT nextval('topics_id_seq'::regclass) NOT NULL  ,
	create_date          timestamp    ,
	name                 varchar    ,
	topic_id             integer    ,
	"order"              integer    ,
	priority             integer    ,
	color                varchar    ,
	owner_user_id        integer    ,
	CONSTRAINT topics_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".comments ( 
	id                   integer DEFAULT nextval('comments_id_seq'::regclass) NOT NULL  ,
	text                 text  NOT NULL  ,
	topic_id             integer  NOT NULL  ,
	user_id              integer  NOT NULL  ,
	created_at           timestamp DEFAULT CURRENT_TIMESTAMP   ,
	CONSTRAINT comments_pkey PRIMARY KEY ( id )
 );

CREATE  TABLE "public".shared_topics ( 
	id                   integer DEFAULT nextval('shared_topics_id_seq'::regclass) NOT NULL  ,
	user_shared_id       integer  NOT NULL  ,
	topic_id             integer  NOT NULL  ,
	user_destination_id  integer  NOT NULL  ,
	CONSTRAINT shared_topics_pkey PRIMARY KEY ( id )
 );

ALTER TABLE "public".comments ADD CONSTRAINT comments_topic_id_fkey FOREIGN KEY ( topic_id ) REFERENCES "public".topics( id );

ALTER TABLE "public".comments ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY ( user_id ) REFERENCES "public".users( id );

ALTER TABLE "public".shared_topics ADD CONSTRAINT shared_topics_topic_id_fkey FOREIGN KEY ( topic_id ) REFERENCES "public".topics( id );

ALTER TABLE "public".shared_topics ADD CONSTRAINT shared_topics_user_destination_id_fkey FOREIGN KEY ( user_destination_id ) REFERENCES "public".users( id );

ALTER TABLE "public".shared_topics ADD CONSTRAINT shared_topics_user_shared_id_fkey FOREIGN KEY ( user_shared_id ) REFERENCES "public".users( id );

ALTER TABLE "public".themes ADD CONSTRAINT themes_owner_user_id_fkey FOREIGN KEY ( owner_user_id ) REFERENCES "public".users( id );

ALTER TABLE "public".themes_properties ADD CONSTRAINT themes_properties_theme_id_fkey FOREIGN KEY ( theme_id ) REFERENCES "public".themes( id );

ALTER TABLE "public".topics ADD CONSTRAINT topics_topic_id_fkey FOREIGN KEY ( topic_id ) REFERENCES "public".topics( id );

ALTER TABLE "public".topics ADD CONSTRAINT topics_owner_user_id_fkey FOREIGN KEY ( owner_user_id ) REFERENCES "public".users( id );

