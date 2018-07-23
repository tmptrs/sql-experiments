DROP TABLE IF EXISTS SAT_city_country_capital;
DROP TABLE IF EXISTS SAT_City_Fast;
DROP TABLE IF EXISTS SAT_City_Slow;
DROP TABLE IF EXISTS SAT_Country_Countrylanguage_Fast;
DROP TABLE IF EXISTS SAT_Country_Countrylanguage_Slow;
DROP TABLE IF EXISTS SAT_Country_Gnp;
DROP TABLE IF EXISTS SAT_Country_Headofstate;
DROP TABLE IF EXISTS SAT_Country_Lifeexpectancy;
DROP TABLE IF EXISTS SAT_Country_Population;
DROP TABLE IF EXISTS SAT_Country_Slow;
DROP TABLE IF EXISTS LNK_City_Country;
DROP TABLE IF EXISTS LNK_Country_Countrylanguage;
DROP TABLE IF EXISTS HUB_City;
DROP TABLE IF EXISTS HUB_Country;
DROP TABLE IF EXISTS HUB_Countrylanguageuage;



CREATE TABLE HUB_City
(
	id integer NOT NULL,
	name text NOT NULL,
	load_date timestamp NOT NULL,
	record_source text NOT NULL,

	CONSTRAINT HUB_City_PK PRIMARY KEY (id)
);


CREATE TABLE HUB_Country
(
	code character(3) NOT NULL,
	name text NOT NULL,
	load_date timestamp NOT NULL,
	record_source text,

	CONSTRAINT HUB_Country_PK PRIMARY KEY (code)
);


CREATE TABLE HUB_Countrylanguage
(
	id SERIAL NOT NULL,
	countrycode character(3) NOT NULL,
	language text NOT NULL,
	load_date timestamp NOT NULL,
	record_source text,

	CONSTRAINT HUB_Countrylanguage_PK PRIMARY KEY (id)
);


CREATE TABLE LNK_City_Country
(
	id integer NOT NULL REFERENCES HUB_City (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	code character(3) NOT NULL REFERENCES HUB_Country (code)
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	load_date timestamp NOT NULL,
	record_source text NOT NULL,

	CONSTRAINT LNK_City_Country_PK PRIMARY KEY (id, code)
);

CREATE TABLE LNK_Country_Countrylanguage
(
	code character(3) NOT NULL
	REFERENCES HUB_Country (code)
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	id integer NOT NULL
	REFERENCES HUB_Countrylanguage (id)
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	load_date timestamp NOT NULL,
	record_source text NOT NULL,

	CONSTRAINT LNK_City_Countrylanguage_PK PRIMARY KEY (id, code)
);


CREATE TABLE SAT_city_country_capital
(
	id integer NOT NULL,
	code character(3) NOT NULL,
	capital integer,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_city_country_capital_PK PRIMARY KEY (id, code),
	CONSTRAINT SAT_city_country_capital_FK FOREIGN KEY (id, code) REFERENCES
	LNK_City_Country (id, code)
);


CREATE TABLE SAT_City_Fast
(
	id integer NOT NULL,
	population integer NOT NULL,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_City_Fast_PK PRIMARY KEY (id),
	CONSTRAINT SAT_City_Fast_FK FOREIGN KEY (id) REFERENCES
	HUB_City (id)
);


CREATE TABLE SAT_City_Slow
(
	id integer NOT NULL,
	district text NOT NULL,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_City_Slow_PK PRIMARY KEY (id),
	CONSTRAINT SAT_City_Slow_FK FOREIGN KEY (id) REFERENCES
	HUB_City (id)
);


CREATE TABLE SAT_Country_Countrylanguage_Fast
(
	id integer NOT NULL,
	code character(3) NOT NULL,
	percentage real NOT NULL,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_Country_Countrylanguage_fast_PK PRIMARY KEY (id, code),
	CONSTRAINT SAT_Country_Countrylanguage_fast_FK FOREIGN KEY (id, code) REFERENCES
	LNK_Country_Countrylanguage (id, code)
);


CREATE TABLE SAT_Country_Countrylanguage_Slow
(
	id integer NOT NULL,
	code character(3) NOT NULL,
	isOfficial boolean NOT NULL,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_Country_Countrylanguage_slow_PK PRIMARY KEY (id, code),
	CONSTRAINT SAT_Country_Countrylanguage_slow_FK FOREIGN KEY (id, code) REFERENCES
	LNK_Country_Countrylanguage (id, code)
);


CREATE TABLE SAT_Country_Gnp
(
	code character(3) NOT NULL,
	gnp numeric(10,2),
	gnpold numeric(10,2),
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_Country_Gnp_PK PRIMARY KEY (code),
	CONSTRAINT SAT_Country_Gnp_FK FOREIGN KEY (code) REFERENCES
	HUB_Country (code)
);


CREATE TABLE SAT_Country_Headofstate
(
	code character(3) NOT NULL,
	headofstate text,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_Country_Headofstate_PK PRIMARY KEY (code),
	CONSTRAINT SAT_Country_Headofstate_FK FOREIGN KEY (code) REFERENCES
	HUB_Country (code)
);


CREATE TABLE SAT_Country_Lifeexpectancy
(
	code character(3) NOT NULL,
	lifeexpectancy real,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_Country_Lifeexpectancy_PK PRIMARY KEY (code),
	CONSTRAINT SAT_Country_Lifeexpectancy_FK FOREIGN KEY (code) REFERENCES
	HUB_Country (code)
);


CREATE TABLE SAT_Country_Population
(
	code character(3) NOT NULL,
	population integer NOT NULL,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_Country_Population_PK PRIMARY KEY (code),
	CONSTRAINT SAT_Country_Population_FK FOREIGN KEY (code) REFERENCES
	HUB_Country (code)
);


CREATE TABLE SAT_Country_Slow
(
	code character(3) NOT NULL,
	continent text NOT NULL,
	region text NOT NULL,
	surfacearea real NOT NULL,
	indepyear smallint,
	localname text NOT NULL,
	governmentform text NOT NULL,
	code2 character(2) NOT NULL,
	load_date timestamp NOT NULL,
	CONSTRAINT SAT_Country_Slow_PK PRIMARY KEY (code),
	CONSTRAINT SAT_Country_Slow_FK FOREIGN KEY (code) REFERENCES
	HUB_Country (code)
);

