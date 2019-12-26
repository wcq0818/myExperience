--//一、创建job示例：
declare job_n number;
begin
  dbms_job.submit(job_n ,'procedures_name;',sysdate,'TRUNC(sysdate+1)+22/24');
  commit;
end;

VAR JOB_NUM NUMBER;
 BEGIN
    DBMS_JOB.SUBMIT(:JOB_NUM,
    WHAT => 'PRO_CREATE_PARTION_TABLES;',
    NEXT_DATE => LAST_DAY(SYSDATE), 
    INTERVAL => 'ADD_MONTHS(LAST_DAY(SYSDATE),1)');
 END; 
 /
COMMIT;
EXIT;

select * from dba_jobs where log_user like 'HESPT_MT1'; 
select * from dba_jobs where log_user like 'HES_DEV'; 
select * from dba_jobs where log_user like 'HESEG_MT';  

select * from dba_jobs where what like 'PRO_CREATE_PARTION_TABLES;';

select * from dba_jobs_running; --正在运行的

select to_char(sysdate,'YYYY-MM-DD W HH24:MI:SS') from dual;
select to_char(last_day(sysdate),'YYYY-MM-DD W HH24:MI:SS') from dual;
select last_day(sysdate) from dual;