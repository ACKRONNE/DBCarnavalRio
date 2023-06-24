-- I N D I C E S 

CREATE INDEX ama_inre ON ama_reservas (id_cliente);
CREATE INDEX ama_ines ON ama_escuelas_samba (id_region);
CREATE INDEX ama_inpr ON ama_protagonistas (id_escuela);
CREATE INDEX ama_inmo ON ama_carnavales_anuales (id_momo);
CREATE INDEX ama_inca ON ama_carnavales_anuales (id_reina);
CREATE INDEX ama_inev ON ama_eventos (id_lugar);
CREATE INDEX ama_inen ON ama_entradas (id_reservas);