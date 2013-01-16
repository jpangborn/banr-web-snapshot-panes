-- TREQ - Financial Aid Requirements
-- Displays the student's financial aid requirements

-- Sequence: 1
-- Columsn: 0

select rrrareq_treq_code || ' - ' || rtvtreq_long_desc as "Requirement", 
  rrrareq_trst_code || ' - ' || rtvtrst_desc as "Status", 
  rrrareq_sat_ind as "Satisfied", 
  to_char(rrrareq_est_date, 'FMMONTH DD, YYYY') as "Created", 
  to_char(rrrareq_stat_date, 'FMMONTH DD, YYYY') as "Status Date", 
  rrrareq_fund_code as "Fund" 
from rrrareq 
left join rtvtreq 
  on rrrareq_treq_code = rtvtreq_code 
left join rtvtrst 
  on rrrareq_trst_code = rtvtrst_code 
where rrrareq_aidy_code = :AIDY 
  and rrrareq_pidm = :PIDM 
  and rrrareq_sat_ind = 'N' 
union 
select rrrareq_treq_code || ' - ' || rtvtreq_long_desc as "Requirement", 
  rrrareq_trst_code || ' - ' || rtvtrst_desc as "Status", 
  rrrareq_sat_ind as "Satisfied", 
  to_char(rrrareq_est_date, 'FMMONTH DD, YYYY') as "Created", 
  to_char(rrrareq_stat_date, 'FMMONTH DD, YYYY') as "Status Date", 
  rrrareq_fund_code as "Fund" 
from rrrareq 
left join rtvtreq 
  on rrrareq_treq_code = rtvtreq_code 
left join rtvtrst 
  on rrrareq_trst_code = rtvtrst_code 
where rrrareq_aidy_code = :AIDY 
  and rrrareq_pidm = :PIDM 
  and rrrareq_sat_ind = 'Y'