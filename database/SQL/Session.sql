select round(BYTES/1024/1024,2)||'M' from user_segments where segment_name='OMS_STATUS_TASK';

select * from user_segments where segment_name='OMS_STATUS_TASK';

select round(BYTES/1024/1024,2)||'M' from user_segments where segment_name='OMS_STATUS_COLL_TASK_CYCLE';

select * from user_segments where segment_name='OMS_STATUS_COLL_TASK_CYCLE';

select username,sid,serial# from v$session;

select * from v$session;