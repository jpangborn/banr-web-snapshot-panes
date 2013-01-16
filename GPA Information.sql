-- PGPA - Current Aid Year GPA Info
-- Dipslay Information about the student's GPA and Credits

-- Sequence: 1
-- Columns: 1

select shrlgpa_levl_code as "Level Code", 
  shrlgpa_hours_attempted as "Hours Attempted", 
  shrlgpa_hours_earned as "Hours Earned", 
  round(shrlgpa_gpa, 2) as "Cumulative GPA", 
  baninst1.mc_aid_year_gpa(shrlgpa_pidm, :AIDY - 101, shrlgpa_levl_code) as "Previous Year GPA", 
  baninst1.mc_terms_full_time(shrlgpa_pidm, shrlgpa_levl_code) as "Terms Full-Time" 
from shrlgpa, rorstat 
where shrlgpa_pidm = rorstat_pidm 
  and rorstat_aidy_code = :AIDY 
  and shrlgpa_gpa_type_ind = 'O' 
  and ((rorstat_tgrp_code LIKE 'GR%' 
    and shrlgpa_levl_code = 'GR') 
  or (rorstat_tgrp_code NOT LIKE 'GR%' 
    and shrlgpa_levl_code = 'UG')) 
  and shrlgpa_pidm = :PIDM