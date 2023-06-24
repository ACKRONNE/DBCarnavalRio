-- C R E A R  T A B L A S

CREATE TABLE ama_clientes (
	id_cliente		integer			NOT NULL		DEFAULT nextval('seq_clientes'),
	nombre			varchar(10) 	NOT NULL,
	apellido1		varchar(10)		NOT NULL,
	nacionalidad	char(1)			NOT NULL		CHECK (nacionalidad IN ('n','e')),
	fecha_nac		date			NOT NULL,		
	dni				integer			NOT NULL		UNIQUE,
	correo			varchar(30)		NOT NULL		UNIQUE,
	apellido2		varchar(10),
	CONSTRAINT 		pk_clie			PRIMARY KEY		(id_cliente)		
);

CREATE TABLE ama_lugares_evento (
	id_lugar		integer			NOT NULL		DEFAULT nextval('seq_lugares_evento'),
	nombre			varchar(50) 	NOT NULL,
	direccion		text			NOT NULL,
	CONSTRAINT 		pk_luga			PRIMARY KEY		(id_lugar)
);

CREATE TABLE ama_regiones_rio (
	id_region		integer			NOT NULL		DEFAULT nextval('seq_regiones_rio'),
	nombre			varchar(50) 	NOT NULL,
	descripcion		text,
	CONSTRAINT 		pk_reri			PRIMARY KEY		(id_region)
);

CREATE TABLE ama_empresas (
	id_empresa		integer			NOT NULL		DEFAULT nextval('seq_empresas'),
	nombre			varchar(30) 	NOT NULL		UNIQUE,
	correo			varchar(30)		NOT NULL		UNIQUE,
	CONSTRAINT 		pk_empe			PRIMARY KEY		(id_empresa)
);

-- S O L O  U N A (1)  F O R E I N G  K E Y

CREATE TABLE ama_autorizaciones (
	id_empresa 		integer			NOT NULL,
	cant_max		integer			NOT NULL,
	CONSTRAINT 		pk_auto			PRIMARY KEY		(id_empresa)
);

ALTER TABLE ama_autorizaciones 
ADD CONSTRAINT fka_auto_emp     FOREIGN KEY     (id_empresa)    REFERENCES  ama_empresas (id_empresa);

CREATE TABLE ama_tipos_entradas (
	id_tipo			integer			NOT NULL		DEFAULT nextval('seq_tipos_entradas'),
	id_empresa		integer			NOT NULL,
	tipo_ent		varchar(2)		NOT NULL		CHECK (tipo_ent IN ('GP','GF','AN','SL')),
	sector			integer			NOT NULL		CHECK ((sector >= 1) AND (sector <= 11)),
	calidad			integer			NOT NULL		CHECK ((calidad >= 1) AND (calidad <= 8)),
	tipo_des		char(1)			NOT NULL		CHECK (tipo_des IN ('e', 'c', 'a')),
	ubi				varchar(3)						CHECK (ubi IN ('A', 'B','C', 'A/B', 'C/D')),
	CONSTRAINT 		pk_tien			PRIMARY KEY (id_tipo,id_empresa)	
);

ALTER TABLE ama_tipos_entradas
ADD CONSTRAINT fkt_emp_tip      FOREIGN KEY     (id_empresa)    REFERENCES  ama_autorizaciones (id_empresa);

CREATE TABLE ama_reservas (
	id_reservas		integer			NOT NULL		DEFAULT nextval('seq_reservas'),
	id_cliente		integer			NOT NULL,
	f_h_emi			timestamp		NOT NULL,
	monto_reales	real,
	fecha_pago		date,
	CONSTRAINT 		pk_rese			PRIMARY KEY		(id_reservas)		
);

ALTER TABLE ama_reservas
ADD CONSTRAINT fkr_reser        FOREIGN KEY    (id_cliente)     REFERENCES ama_clientes(id_cliente);

CREATE TABLE ama_escuelas_samba (
	id_escuela 		integer			NOT NULL		DEFAULT nextval('seq_escuelas_samba'),
	nombre_gres		text			NOT NULL,
	fecha_funda		date			NOT NULL,
	direccion		text			NOT NULL,
	color			text			NOT NULL,
	resumen_hist	text			NOT NULL,
	id_region		integer			NOT	NULL,
	CONSTRAINT 		pk_escu			PRIMARY KEY		(id_escuela)
);

ALTER TABLE ama_escuelas_samba
ADD CONSTRAINT fkes_escu        FOREIGN KEY    (id_region)      REFERENCES ama_regiones_rio(id_region);

CREATE TABLE ama_hist_grupos (
	id_escuela		integer			NOT NULL,
	fecha_ini		date			NOT NULL,
	grupo			char(1)			NOT NULL		CHECK (grupo IN ('a','e')),
	fecha_fin		date,
	CONSTRAINT 		pk_higr			PRIMARY KEY		(id_escuela)
);

ALTER TABLE ama_hist_grupos
ADD CONSTRAINT fkhg_idesc 		FOREIGN KEY    (id_escuela)     REFERENCES ama_escuelas_samba(id_escuela);


CREATE TABLE ama_protagonistas (
	id_prota		integer			NOT NULL		DEFAULT nextval('seq_protagonistas'),
	nombre			varchar(15)		NOT NULL,
	apellido1		varchar(15)		NOT NULL,
	genero			char(1)			NOT NULL		CHECK (genero IN ('f','m')),
	fecha_nac		date			NOT NULL,
	dni				integer			NOT NULL		UNIQUE,
	apellido2		varchar(15),
	id_escuela		integer,
	CONSTRAINT 		pk_prot			PRIMARY KEY		(id_prota)
);

ALTER TABLE ama_protagonistas
ADD CONSTRAINT fkp_idesc        FOREIGN KEY    (id_escuela)     REFERENCES ama_escuelas_samba(id_escuela);


-- D O S  O  M A S  F K

CREATE TABLE ama_carnavales_anuales (
	ano				integer			NOT NULL		DEFAULT nextval('seq_carnavales_anuales'),
	fecha_ini		date			NOT NULL,
	fecha_fin		date			NOT NULL,
	id_momo			integer			NOT NULL,
	id_reina		integer			NOT NULL,
	CONSTRAINT 		pk_carn			PRIMARY KEY		(ano)
);

ALTER TABLE ama_carnavales_anuales
ADD CONSTRAINT fkca_momo        FOREIGN KEY    (id_momo)        REFERENCES ama_protagonistas(id_prota),
ADD CONSTRAINT fkca_reina       FOREIGN KEY    (id_reina)       REFERENCES ama_protagonistas(id_prota);


CREATE TABLE ama_eventos (
	ano 			integer			NOT NULL,
	id_evento		integer			NOT NULL		DEFAULT nextval('seq_eventos'),
	id_lugar		integer			NOT NULL,
	tipo			char(1)			NOT NULL		CHECK (tipo IN ('g','d')),
	fecha_ini		date			NOT NULL,
	hora_ini		time			NOT NULL,					
	tipo_audi		integer			NOT NULL,
	pago			char(1)			NOT NULL		CHECK (pago IN ('s','n')),
	descripcion		text,
	costo_reales	real,
	CONSTRAINT 		pk_even			PRIMARY KEY (id_evento,ano)
);

ALTER TABLE ama_eventos
ADD CONSTRAINT fkev_ano         FOREIGN KEY    (ano)            REFERENCES ama_carnavales_anuales(ano),
ADD CONSTRAINT fkev_lug         FOREIGN KEY    (id_lugar)       REFERENCES ama_lugares_evento(id_lugar);


CREATE TABLE ama_participaciones (
	id_evento		integer			NOT NULL,
	ano				integer			NOT NULL,
	id_escuela		integer			NOT NULL,
	hora_ini		time			NOT NULL,
	orden_des		integer			NOT NULL,
	posicion_fin	integer			NOT NULL,
	tema_gen		text			NOT NULL,
	titu_letr		text			NOT NULL,
	CONSTRAINT 		pk_part			PRIMARY KEY (id_evento,ano,id_escuela)
);

ALTER TABLE ama_participaciones
ADD CONSTRAINT fkpa_ideve       FOREIGN KEY (id_evento,ano)        REFERENCES ama_eventos(id_evento,ano),
ADD CONSTRAINT fkpa_idpar       FOREIGN KEY (id_escuela)      	   REFERENCES ama_hist_grupos(id_escuela);



CREATE TABLE ama_roles (
	id_prota		integer			NOT NULL,
	id_evento		integer			NOT NULL,
	ano				integer			NOT NULL,
	id_escuela		integer			NOT NULL,
	nombre			varchar			NOT NULL		CHECK (nombre IN ('rey momo','reina del carnaval','carnavalesco','mestre-sala','porta-bandeira')),
	CONSTRAINT 		pk_rol			PRIMARY KEY 	(id_prota, id_evento, ano, id_escuela)
);

ALTER TABLE ama_roles
ADD CONSTRAINT fkro_idpro       FOREIGN KEY (id_evento,ano,id_escuela)          REFERENCES ama_participaciones(id_evento,ano,id_escuela),
ADD CONSTRAINT fkro_idesc       FOREIGN KEY (id_prota)       					REFERENCES ama_protagonistas(id_prota);


CREATE TABLE ama_detalles_reservas (
	id_empresa		integer			NOT NULL,
	id_reservas		integer			NOT NULL,
	cantidad		integer			NOT NULL,
 	CONSTRAINT 		pk_dere			PRIMARY KEY (id_empresa, id_reservas)
);

ALTER TABLE ama_detalles_reservas
ADD CONSTRAINT fkde_idemp       FOREIGN KEY (id_empresa)        REFERENCES ama_autorizaciones(id_empresa),
ADD CONSTRAINT fkde_idres       FOREIGN KEY (id_reservas)       REFERENCES ama_reservas(id_reservas);

CREATE TABLE ama_entradas (
	id_entrada		integer			NOT NULL		DEFAULT nextval('seq_entradas'),
	id_evento		integer			NOT NULL,
	ano				integer			NOT NULL,
	id_reservas		integer			NOT NULL,
	hora_emi		time			NOT NULL,
	f_emision		date			NOT NULL,
	CONSTRAINT 		pk_entr			PRIMARY KEY (id_evento, ano, id_entrada)
);

ALTER TABLE ama_entradas
ADD CONSTRAINT fken_ideve       FOREIGN KEY (id_evento,ano)     REFERENCES ama_eventos(id_evento,ano),
ADD CONSTRAINT fken_idres       FOREIGN KEY (id_reservas)       REFERENCES ama_reservas(id_reservas);

CREATE TABLE ama_hist_precios (
	id_empresa		integer			NOT NULL,
	id_tipo			integer			NOT NULL,
	ano	   			integer			NOT NULL,
	id_evento	    integer			NOT NULL,
	id_entrada	   	integer			NOT NULL,
	fecha_inicio	date			NOT NULL,
	costo_reales	real			NOT NULL,
	fecha_fin		date,
	CONSTRAINT 		pk_hipr			PRIMARY KEY (fecha_inicio,id_tipo,id_empresa, id_entrada,id_evento,ano)
);

ALTER TABLE ama_hist_precios
ADD CONSTRAINT fkhp_ident       FOREIGN KEY (id_evento,ano,id_entrada)        REFERENCES ama_entradas(id_evento,ano,id_entrada),
ADD CONSTRAINT fkhp_ideve       FOREIGN KEY (id_tipo,id_empresa)         	  REFERENCES ama_tipos_entradas(id_tipo,id_empresa);
