-- C R E A R  T A B L A S

CREATE TABLE ama_clientes (
	id_cliente		SERIAL,
	nombre			varchar(10) 	NOT NULL,
	apellido1		varchar(10)		NOT NULL,
	nacionalidad	char			NOT NULL		CHECK (nacionalidad IN ('n','e')),
	fecha_nac		date			NOT NULL,		
	dni				integer			NOT NULL		UNIQUE,
	correo			varchar(30)		NOT NULL		UNIQUE,
	apellido2		varchar(10),
	CONSTRAINT 		pk_clie			PRIMARY KEY		(id_cliente)		
);

CREATE TABLE ama_lugares_evento (
	id_lugar		SERIAL,
	nombre			text 			NOT NULL,
	direccion		text			NOT NULL,
	CONSTRAINT 		pk_luga			PRIMARY KEY		(id_lugar)
);

CREATE TABLE ama_regiones_rio (
	id_region		SERIAL,
	nombre			text 			NOT NULL,
	descripcion		text,
	CONSTRAINT 		pk_reri			PRIMARY KEY		(id_region)
);

CREATE TABLE ama_empresas (
	id_empresa		SERIAL,
	nombre			varchar(21) 	NOT NULL		UNIQUE,
	correo			varchar(30)		NOT NULL		UNIQUE,
	CONSTRAINT 		pk_empe			PRIMARY KEY		(id_empresa)
);

-- S O L O  U N A (1)  F O R E I N G  K E Y

CREATE TABLE ama_autorizaciones (
	id_empresa 		SERIAL,
	cant_max		integer			NOT NULL,
	CONSTRAINT 		pk_auto			PRIMARY KEY		(id_empresa)
);

CREATE TABLE ama_tipos_entradas (
	id_empresa		integer,
	id_tipo			SERIAL			UNIQUE,
	tipo_ent		varchar(2)		NOT NULL		CHECK (tipo_ent IN ('gp','gf','an','sl')),
	sector			integer			NOT NULL		CHECK ((sector >= 1) AND (sector <= 11)),
	calidad			integer			NOT NULL		CHECK ((calidad >= 1) AND (calidad <= 11)),
	tipo_des		char			NOT NULL		CHECK (tipo_des IN ('e', 'c', 'a')),
	ubi				varchar(3)						CHECK (ubi IN ('a', 'b','c', 'a/b', 'c/d')),
	CONSTRAINT 		pk_tien			PRIMARY KEY (id_empresa, id_tipo)	
);

CREATE TABLE ama_reservas (
	id_reservas		SERIAL,
	f_h_emi			timestamp		NOT NULL,
	id_cliente		integer			NOT NULL		UNIQUE,
	monto_reales	real,
	fecha_pago		date,
	CONSTRAINT 		pk_rese			PRIMARY KEY		(id_reservas)		
);

CREATE TABLE ama_escuelas_samba (
	id_escuela 		SERIAL,
	nombre_gres		text			NOT NULL,
	fecha_funda		date			NOT NULL,
	direccion		text			NOT NULL,
	color			text			NOT NULL,
	resumen_hist	text			NOT NULL,
	id_region		integer			NOT	NULL,
	CONSTRAINT 		pk_escu			PRIMARY KEY		(id_escuela)
);

CREATE TABLE ama_hist_grupos (
	id_escuela		integer,
	id_histg		SERIAL							UNIQUE,
	fecha_ini		date,
	grupos			char			NOT NULL		CHECK (grupos IN ('a','e')),
	fecha_fin		date							UNIQUE,
	CONSTRAINT 		pk_higr			PRIMARY KEY		(id_escuela,id_histg)
);

CREATE TABLE ama_protagonistas (
	id_prota		SERIAL,
	nombre			varchar(15)		NOT NULL,
	apellido1		varchar(15)		NOT NULL,
	genero			char			NOT NULL		CHECK (genero IN ('f','m')),
	fecha_nac		date			NOT NULL,
	dni				integer			NOT NULL		UNIQUE,
	apellido2		varchar(15),
	id_escuela		integer,
	CONSTRAINT 		pk_prot			PRIMARY KEY		(id_prota)
);

-- D O S  O  M A S  F K

CREATE TABLE ama_carnavales_anuales (
	ano				integer,
	fecha_ini		date			NOT NULL,
	fecha_fin		date			NOT NULL,
	id_momo			integer			NOT NULL,
	id_reina		integer			NOT NULL,
	CONSTRAINT 		pk_carn			PRIMARY KEY		(ano)
);

CREATE TABLE ama_eventos (
	ano 			integer,
	id_evento		SERIAL			UNIQUE,
	tipo			char			NOT NULL		CHECK (tipo IN ('g','d')),
	fecha_ini		date			NOT NULL,
	hora_ini		time			NOT NULL,					
	tipo_audi		integer			NOT NULL,
	pago			char			NOT NULL		CHECK (pago IN ('s','n')),
	descripcion		text,
	costo_reales	real,
	id_lugar		integer,
	CONSTRAINT 		pk_even			PRIMARY KEY (ano, id_evento)
);

CREATE TABLE ama_participaciones (
	id_escuela		integer,
	id_histg		integer,
	id_evento		integer,
	hora_ini		time			NOT NULL,
	orden_des		integer			NOT NULL,
	posicion_fin	integer			NOT NULL,
	tema_gen		text			NOT NULL,
	titu_letr		text			NOT NULL,
	CONSTRAINT 		pk_part			PRIMARY KEY (id_escuela, id_histg, id_evento)
);

CREATE TABLE ama_roles (
	id_prota		integer,
	id_escuela		integer,
	id_histg		integer,
	id_evento		integer,
	nombre			varchar			NOT NULL		CHECK (nombre IN ('rey momo','reina del carnaval','carnavalesco','mestre-sala','porta-bandeira')),
	CONSTRAINT 		pk_rol			PRIMARY KEY 	(id_prota, id_escuela, id_histg,id_evento)
);

CREATE TABLE ama_detalles_reservas (
	id_reservas		integer,
	id_empresa		integer,
	cantidad		integer,
 	CONSTRAINT 		pk_dere			PRIMARY KEY (id_reservas, id_empresa)
);

CREATE TABLE ama_entradas (
	ano				integer,
	id_evento		integer,
	id_entrada		SERIAL							UNIQUE,
	hora_emi		time			NOT NULL,
	f_emision		date			NOT NULL,
	id_reservas		integer							UNIQUE,
	CONSTRAINT 		pk_entr			PRIMARY KEY (ano, id_evento, id_entrada)
);

CREATE TABLE ama_historicos_precios (
	id_empresa		integer,
	id_tipo			integer,
	ano	   			integer,
	id_evento	    integer,
	id_entrada	   	integer,
	fecha_inicio	date,
	costo_reales	real			NOT NULL,
	fecha_fin		date,
	CONSTRAINT 		pk_hipr			PRIMARY KEY (id_empresa, id_tipo, ano, id_evento, id_entrada, fecha_inicio)
);