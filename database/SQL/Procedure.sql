CREATE OR REPLACE PROCEDURE PRO_DEL_ADD_PARTITION
AS
/***************************************************
  ** 功能：按日添加本月的分区
  ** 创建者：sfit1053
  ** 创建时间：20150825
  ****************************************************/
  l_from_date  DATE;            -- 存放循环起始日期(当月的第一天)
  l_to_date    DATE;            -- 存放循环截止日期(下月的第一天)
  l_partition  VARCHAR2(30);    -- 表分区名
  l_p_exist    NUMBER(18,0);    -- 判断表分区是否已经存在
  l_sql1       VARCHAR2(200);   -- 存放将要执行的SQL语句
  l_sql2       VARCHAR2(1000);   -- 存放将要执行的SQL语句
  l_sql3       VARCHAR2(200);   -- 存放将要执行的SQL语句
  RET_MSG      VARCHAR2(300);   --执行出错错误信息

BEGIN

  l_from_date  := TRUNC(sysdate,'MM'); --返回当月第一天
  l_to_date    := ADD_MONTHS(l_from_date, 1);--将一个日期上加上一指定的月份数

  WHILE l_from_date < l_to_date LOOP
    l_partition := 'D'||TO_CHAR(l_from_date,'YYYYMMDD');
    SELECT NVL(COUNT(1), 0) INTO l_p_exist
      FROM USER_TAB_PARTITIONS
     WHERE table_name='UCMP_PUSH_MESSAGE'
       AND partition_name=l_partition;

    IF l_p_exist = 0 THEN
        l_sql1 := 'ALTER TABLE UCMP_PUSH_MESSAGE_BAK ADD PARTITION "'||l_partition||'" VALUES LESS THAN (to_date('''||TO_CHAR(l_from_date,'YYYY-MM-DD')||''','''||'yyyy-mm-dd'||'''))';
        l_sql3 := 'ALTER TABLE UCMP_PUSH_MESSAGE ADD PARTITION "'||l_partition||'" VALUES LESS THAN (to_date('''||TO_CHAR(l_from_date,'YYYY-MM-DD')||''','''||'yyyy-mm-dd'||'''))';
       EXECUTE IMMEDIATE l_sql1;
       EXECUTE IMMEDIATE l_sql3;
    END IF;
    l_from_date := l_from_date + 1;
  END LOOP;
  RET_MSG := 'OK';
EXCEPTION WHEN OTHERS THEN
 BEGIN
   RET_MSG  := '存储过程PRO_DEL_ADD_PARTITION执行错误!' || CHR(10) || '错误代码：' || SQLCODE || CHR(10) || '错误信息：' || SUBSTR(SQLERRM, 1, 128);
 END;
l_sql2 := 'insert into ucmp_cl_script_log(pro_name,log_time,log_des) values(''PRO_DEL_ADD_PARTITION'',sysdate,'''||RET_MSG||''')';
EXECUTE IMMEDIATE l_sql2;
COMMIT;
END PRO_DEL_ADD_PARTITION;