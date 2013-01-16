-- PCHD - Current Aid Year Holds
-- Displays the Financial Aid Holds for a Student. Includes holds for the current aid year and holds not assigned to any aid year.

-- Sequence: 1
-- Columns: 1

select rorhold_hold_code || ' - ' || rtvhold_desc as "Hold", 
  rorhold_aidy_code as "Aid Year", 
  rorhold_period as "Period", 
  rorhold_from_date || ' - ' || rorhold_to_date as "Date Range", 
  rorhold_user_id as "Updated By", 
  rorhold_reason as "Reason" 
from rorhold
left join rtvhold
  on rorhold_hold_code = rtvhold_code 
where rorhold_pidm = :PIDM 
  and (rorhold_aidy_code = :AIDY 
    or rorhold_aidy_code is null)