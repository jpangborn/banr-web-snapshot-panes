-- PCLT - Ten Most Recent Letters
-- Displays the ten most recent letters sent from the Financial Aid module

-- Sequence: 1
-- Columns: 0

select * 
from (select gurmail_aidy_code as "Aid Year", 
    gurmail_letr_code || ' - ' || gtvletr_desc as "Letter", 
    to_char(gurmail_date_printed, 'FMMONTH DD, YYYY') as "Date Sent" 
  from gurmail, gtvletr 
  where gurmail_system_ind = 'R' 
    and gurmail_pidm = :PIDM 
    and gtvletr_code = gurmail_letr_code 
  order by gurmail_date_printed desc) 
where rownum <= 10