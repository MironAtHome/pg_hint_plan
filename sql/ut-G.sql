LOAD 'pg_hint_plan';
SET pg_hint_plan.enable TO on;
SET pg_hint_plan.debug_print TO on;
SET search_path TO public;

----
---- No. G-2-2 category of GUC parameter and role
----

-- No. G-2-2-1
SET ROLE super_user;
/*+Set(block_size 16384)*/
SELECT * FROM s1.t1 WHERE t1.c1 = 1;

-- No. G-2-2-2
/*+Set(archive_mode off)*/
SELECT * FROM s1.t1 WHERE t1.c1 = 1;

-- No. G-2-2-3
/*+Set(archive_timeout 0)*/
SELECT * FROM s1.t1 WHERE t1.c1 = 1;

-- No. G-2-2-4
/*+Set(log_connections off)*/
SELECT * FROM s1.t1 WHERE t1.c1 = 1;

-- No. G-2-2-5
/*+Set(log_min_messages WARNING)*/
SELECT * FROM s1.t1 WHERE t1.c1 = 1;
RESET ROLE;

-- No. G-2-2-6
GRANT ALL ON SCHEMA s1 TO PUBLIC;
GRANT SELECT ON ALL TABLES IN SCHEMA s1 TO normal_user;
SET ROLE normal_user;
/*+Set(log_min_messages WARNING)*/
SELECT * FROM s1.t1 WHERE t1.c1 = 1;

-- No. G-2-2-7
/*+Set(enable_seqscan on)*/
SELECT * FROM s1.t1 WHERE t1.c1 = 1;

RESET ROLE;
REVOKE SELECT ON ALL TABLES IN SCHEMA s1 FROM normal_user;
REVOKE ALL ON SCHEMA s1 FROM normal_user;
