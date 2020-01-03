create or replace procedure auto_add_datafile as 
cursor cur_dt is SELECT * FROM 
(SELECT tablespace_name, sum(bytes) / 1024 / 1024 AS MB1 FROM dba_free_space GROUP BY tablespace_name) free, 
(SELECT tablespace_name, sum(bytes) / 1024 / 1024 AS MB2 FROM dba_data_files GROUP BY tablespace_name) total  
WHERE free.tablespace_name = total.tablespace_name and free.tablespace_name  = 'HES';
Begin 
 FOR my_cur IN (SELECT * FROM t_test) LOOP
    INSERT INTO t_test_max VALUES my_cur;
 END LOOP;
End auto_add_datafile;

select sum(t1.bytes)/1024/1024, sum(t1.bytes)/1024/1024 from dba_free_space t1, dba_data_files t2 where t1.tablespace_name = t2.tablespace_name and t1.tablespace_name = 'HES';

CREATE OR REPLACE PROCEDURE EMP_COUNT  
AS  
V_TOTAL NUMBER(10);  
BEGIN  
 SELECT COUNT(*) INTO V_TOTAL FROM OMS_STATUS_TASK;  
 DBMS_OUTPUT.PUT_LINE('雇员总人数为：'||V_TOTAL);  
END EMP_COUNT;  

execute EMP_COUNT;
ALTER TABLE OMS_STATUS_TASK DROP PARTITION OMS_STATUS_TASK202001;

select * from v$datafile;
select * from v$tablespace;
select * from user_users;
select t1.name, t2.name, t2.bytes  from v$tablespace t1, v$datafile t2 where t1.ts# = t2.ts#;
alter user dev_palestine default tablespace HES;
select * from dba_free_space;
select * from dba_data_files;
