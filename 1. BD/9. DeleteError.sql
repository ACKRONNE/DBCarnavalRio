SELECT * FROM pg_stat_activity WHERE datname = 'carnaval_rio';

SELECT pg_terminate_backend(6432);
SELECT pg_terminate_backend(2096);

DROP DATABASE "carnaval_rio";