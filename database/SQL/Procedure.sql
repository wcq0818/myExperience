CREATE OR REPLACE PROCEDURE PRO_DEL_ADD_PARTITION
AS
/***************************************************
  ** ���ܣ�������ӱ��µķ���
  ** �����ߣ�sfit1053
  ** ����ʱ�䣺20150825
  ****************************************************/
  l_from_date  DATE;            -- ���ѭ����ʼ����(���µĵ�һ��)
  l_to_date    DATE;            -- ���ѭ����ֹ����(���µĵ�һ��)
  l_partition  VARCHAR2(30);    -- �������
  l_p_exist    NUMBER(18,0);    -- �жϱ�����Ƿ��Ѿ�����
  l_sql1       VARCHAR2(200);   -- ��Ž�Ҫִ�е�SQL���
  l_sql2       VARCHAR2(1000);   -- ��Ž�Ҫִ�е�SQL���
  l_sql3       VARCHAR2(200);   -- ��Ž�Ҫִ�е�SQL���
  RET_MSG      VARCHAR2(300);   --ִ�г��������Ϣ

BEGIN

  l_from_date  := TRUNC(sysdate,'MM'); --���ص��µ�һ��
  l_to_date    := ADD_MONTHS(l_from_date, 1);--��һ�������ϼ���һָ�����·���

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
   RET_MSG  := '�洢����PRO_DEL_ADD_PARTITIONִ�д���!' || CHR(10) || '������룺' || SQLCODE || CHR(10) || '������Ϣ��' || SUBSTR(SQLERRM, 1, 128);
 END;
l_sql2 := 'insert into ucmp_cl_script_log(pro_name,log_time,log_des) values(''PRO_DEL_ADD_PARTITION'',sysdate,'''||RET_MSG||''')';
EXECUTE IMMEDIATE l_sql2;
COMMIT;
END PRO_DEL_ADD_PARTITION;