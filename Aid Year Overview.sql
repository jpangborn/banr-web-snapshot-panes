-- PCOV - Current Aid Year Overview
-- Displays an overview of the student's financial aid processing.

-- Sequence: 1
-- Columns: 1

select to_char(rorstat_appl_rcvd_date, 'FMMONTH DD, YYYY') as "FAFSA Receipt Date",
  rorstat_tgrp_code || ' - ' || rtvtgrp_desc as "Tracking Group",
  rorstat_bgrp_code || ' - ' || rtvbgrp_desc as "Budget Group",
  rorstat_pgrp_code || ' - ' || rtvpgrp_desc as "Packaging Group",
  rorstat_aprd_code || ' - ' || rtvaprd_desc as "Aid Period",
  rovsapr_sapr_code || ' - ' || rtvsapr_desc as "Current SAP Status",
  rovspar_term_code as "SAP Effective Term",
  to_char(rorstat_pckg_req_comp_date, 'FMMONTH DD, YYYY') as "Package Requirements Complete",
  to_char(rorstat_pckg_comp_date, 'FMMONTH DD, YYYY') as "Package Complete"
from rorstat
left join rtvtgrp
  on rorstat_tgrp_code = rtvtgrp_code
left join rtvbgrp
  on rorstat_bgrp_code = rtvbgrp_code
left join rtvpgrp
  on rorstat_pgrp_code = rtvpgrp_code
left join rtvaprd
  on rorstat_aprd_code = rtvaprd_code
left join rovsapr
  on rorstat_pidm = rovspar_pidm
where rorstat_aidy_code = :AIDY
  and rorstat_pidm = :PIDM