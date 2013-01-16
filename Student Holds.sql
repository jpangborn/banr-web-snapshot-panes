-- SHLD - Student Holds
-- Displays any unreleased holds from the Student module

-- Sequence: 1
-- Columns: 0

select sprhold_hldd_code || ' - ' || stvhldd_desc as "Hold", 
  to_char(sprhold_amount_owed, '$999,990') as "Amount Owed", 
  sprhold_from_date || ' - ' || sprhold_to_date as "Date Range", 
  sprhold_user as "Updated By", 
  sprhold_orig_code || ' - ' || stvorig_desc as "Originated By", 
  sprhold_release_ind as "Release Ind", 
  sprhold_reason as "Reason" 
from sprhold 
left join stvhldd 
  on sprhold_hldd_code = stvhldd_code 
left join stvorig 
  on sprhold_orig_code = stvorig_code 
where sprhold_pidm = :PIDM 
  and (sprhold_to_date is null 
  or sprhold_to_date > sysdate)