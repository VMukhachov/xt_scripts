set serverout on;
-- �������� ����� ������������ �������
declare
  l_sql_id_src varchar2(13)    :='&sqlid_src';    -- sql_id �������
  l_plan_hash_value_src number := &plan_hv_src;     -- plan_hash_value �������
  l_sql_id_trg  varchar2(13)   :='&sqlid_dest';   -- sql_id �������������� �������
  l_sql_text_trg clob;  
  l_res number;  
begin
  -- ����� ������� ��� ���������
  select a.sql_fulltext 
    into l_sql_text_trg
    from v$sqlarea a 
   where a.sql_id = l_sql_id_trg;
  
  -- �������� ����� � �������� SQL plan baseline
  l_res := dbms_spm.load_plans_from_cursor_cache
           ( sql_id          => l_sql_id_src, 
             plan_hash_value => l_plan_hash_value_src, 
             sql_text        => l_sql_text_trg 
           );
  dbms_output.put_line(l_res);  
end;
/
set serverout off;
