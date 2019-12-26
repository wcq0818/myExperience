select CREATE_TV, to_char(CREATE_TV, 'yyyy-mm-dd hh24:mi:ss') FROM OMS_STATUS_TASK; 
select * from OMS_STATUS_TASK where CREATE_TV > TO_DATE ('2019-12-25 14:00:27','yyyy-mm-dd hh24:mi:ss');

select TRUNC(ADD_MONTHS(LAST_DAY(SYSDATE), 0) + 1) from dual;
select TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAY(SYSDATE), 0) + 1),'yyyymm') from dual;

select ADD_MONTHS(SYSDATE, 2) from dual;
select DATE_TO_NUMBER(TRUNC(ADD_MONTHS(SYSDATE, 2), 'mm')) from dual;

select TRUNC(ADD_MONTHS(SYSDATE, 2), 'mm') from dual;
select DATE_TO_NUMBER(TRUNC(SYSDATE, 'HH24')) from dual;

DECLARE

T_NAME    VARCHAR2(20);
CUR_MONTH VARCHAR2(20);
T_NAME    := TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAY(SYSDATE), 0) + 1),'yyyymm');
CUR_MONTH := DATE_TO_NUMBER(TRUNC(ADD_MONTHS(SYSDATE, 2), 'mm'));
  
EXECUTE IMMEDIATE 'alter table OMS_STATUS_TASK split partition OMS_STATUS_TASK99981212 at CUR_MONTH into (partition T_NAME, partition OMS_STATUS_TASK99981212)';

END