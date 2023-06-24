-- M O D I F I C A C I O N  D E  T A B L A S

ALTER TABLE ama_autorizaciones
ADD CONSTRAINT fka_auto_emp     FOREIGN KEY     (id_empresa)    REFERENCES  ama_empresas (id_empresa);

ALTER TABLE ama_tipos_entradas
ADD CONSTRAINT fkt_emp_tip      FOREIGN KEY     (id_empresa)    REFERENCES  ama_empresas (id_empresa);

ALTER TABLE ama_reservas
ADD CONSTRAINT fkr_reser        FOREIGN KEY    (id_cliente)     REFERENCES ama_clientes(id_cliente);

ALTER TABLE ama_escuelas_samba
ADD CONSTRAINT fkes_escu        FOREIGN KEY    (id_region)      REFERENCES ama_regiones_rio(id_region);

ALTER TABLE ama_hist_grupos
ADD CONSTRAINT fkhg_idesc 		FOREIGN KEY    (id_escuela)     REFERENCES ama_escuelas_samba(id_escuela);

ALTER TABLE ama_protagonistas
ADD CONSTRAINT fkp_idesc        FOREIGN KEY    (id_escuela)     REFERENCES ama_escuelas_samba(id_escuela);

ALTER TABLE ama_carnavales_anuales
ADD CONSTRAINT fkca_momo        FOREIGN KEY    (id_momo)        REFERENCES ama_protagonistas(id_prota),
ADD CONSTRAINT fkca_reina       FOREIGN KEY    (id_reina)       REFERENCES ama_protagonistas(id_prota);

ALTER TABLE ama_eventos
ADD CONSTRAINT fkev_ano         FOREIGN KEY    (ano)            REFERENCES ama_carnavales_anuales(ano),
ADD CONSTRAINT fkev_lug         FOREIGN KEY    (id_lugar)       REFERENCES ama_lugares_evento(id_lugar);

ALTER TABLE ama_participaciones
ADD CONSTRAINT fkpa_idesc       FOREIGN KEY (id_escuela)        REFERENCES ama_escuelas_samba(id_escuela),
ADD CONSTRAINT fkpa_idhistg     FOREIGN KEY (id_histg)          REFERENCES ama_hist_grupos(id_histg),
ADD CONSTRAINT fkpa_idev        FOREIGN KEY (id_evento)         REFERENCES ama_eventos(id_evento);

ALTER TABLE ama_roles
ADD CONSTRAINT fkro_idpro       FOREIGN KEY (id_prota)          REFERENCES ama_protagonistas(id_prota),
ADD CONSTRAINT fkro_idesc       FOREIGN KEY (id_escuela)        REFERENCES ama_escuelas_samba(id_escuela),
ADD CONSTRAINT fkro_idhistg     FOREIGN KEY (id_histg)          REFERENCES ama_hist_grupos(id_histg),
ADD CONSTRAINT fkro_ideve       FOREIGN KEY (id_evento)         REFERENCES ama_eventos(id_evento);

ALTER TABLE ama_detalles_reservas
ADD CONSTRAINT fkde_idres       FOREIGN KEY (id_reservas)       REFERENCES ama_reservas(id_reservas),
ADD CONSTRAINT fkde_idemp       FOREIGN KEY (id_empresa)        REFERENCES ama_empresas(id_empresa);

ALTER TABLE ama_entradas
ADD CONSTRAINT fken_ano         FOREIGN KEY (ano)               REFERENCES ama_carnavales_anuales(ano),
ADD CONSTRAINT fken_ideve       FOREIGN KEY (id_evento)         REFERENCES ama_eventos(id_evento),
ADD CONSTRAINT fken_idres       FOREIGN KEY (id_reservas)       REFERENCES ama_reservas(id_reservas);

ALTER TABLE ama_historicos_precios
ADD CONSTRAINT fkhp_idemp       FOREIGN KEY (id_empresa)        REFERENCES ama_empresas(id_empresa),
ADD CONSTRAINT fkhp_idtip       FOREIGN KEY (id_tipo)           REFERENCES ama_tipos_entradas(id_tipo),
ADD CONSTRAINT fkhp_ano         FOREIGN KEY (ano)               REFERENCES ama_carnavales_anuales(ano),
ADD CONSTRAINT fkhp_ideve       FOREIGN KEY (id_evento)         REFERENCES ama_eventos(id_evento),
ADD CONSTRAINT fkhp_ident       FOREIGN KEY (id_entrada)        REFERENCES ama_entradas(id_entrada);