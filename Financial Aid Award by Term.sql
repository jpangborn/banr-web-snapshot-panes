-- AWTR - Financial Aid Award by Term
-- Displays the student's finanical aid by terms. Includes the annual total of each fund and a totals summary.

-- Sequence: 1
-- Columns: 0

select rprawrd_fund_code || ' - ' || rfrbase_fund_title as "Fund", 
  rprawrd_awst_code as "Status", 
  to_char(nvl(h.rpratrm_offer_amt, 0), '$999,990') as "Header", 
  to_char(nvl(f.rpratrm_offer_amt, 0), '$999,990') as "Fall", 
  to_char(nvl(s.rpratrm_offer_amt, 0), '$999,990') as "Spring", 
  to_char(nvl(t.rpratrm_offer_amt, 0), '$999,990') as "Trailer", 
  to_char(nvl(rprawrd_offer_amt, 0), '$999,990') as "Total" 
from rprawrd 
left join rfrbase 
  on rprawrd_fund_code = rfrbase_fund_code 
left join rpratrm h 
  on rprawrd_pidm = h.rpratrm_pidm 
  and rprawrd_aidy_code = h.rpratrm_aidy_code 
  and rprawrd_fund_code = h.rpratrm_fund_code 
  and h.rpratrm_period = '20' || (to_number(substr(rprawrd_aidy_code, 0, 2)) - 1) || '30' 
left join rpratrm f 
  on rprawrd_pidm = f.rpratrm_pidm 
  and rprawrd_aidy_code = f.rpratrm_aidy_code 
  and rprawrd_fund_code = f.rpratrm_fund_code 
  and f.rpratrm_period = '20' || substr(rprawrd_aidy_code, 0, 2) || '10' 
left join rpratrm s 
  on rprawrd_pidm = s.rpratrm_pidm 
  and rprawrd_aidy_code = s.rpratrm_aidy_code 
  and rprawrd_fund_code = s.rpratrm_fund_code 
  and s.rpratrm_period = '20' || substr(rprawrd_aidy_code, 0, 2) || '20' 
left join rpratrm t 
  on rprawrd_pidm = t.rpratrm_pidm 
  and rprawrd_aidy_code = t.rpratrm_aidy_code 
  and rprawrd_fund_code = t.rpratrm_fund_code 
  and t.rpratrm_period = '20' || substr(rprawrd_aidy_code, 0, 2) || '30' 
where rprawrd_aidy_code = :AIDY 
  and rprawrd_pidm = :PIDM 
order by rfrbase_print_seq_no

-- Sequence: 2    
-- Columns: 1

select to_char(sum(h.rpratrm_offer_amt), '$999,990') as "Header Total", 
  to_char(sum(f.rpratrm_offer_amt), '$999,990') as "Fall Total", 
  to_char(sum(s.rpratrm_offer_amt), '$999,990') as "Spring Total", 
  to_char(sum(t.rpratrm_offer_amt), '$999,990') as "Trailer Total", 
  to_char(sum(rprawrd_offer_amt), '$999,990') as "Grand Total" 
from rprawrd 
left join rfrbase 
  on rprawrd_fund_code = rfrbase_fund_code 
left join rpratrm h 
  on rprawrd_pidm = h.rpratrm_pidm 
  and rprawrd_aidy_code = h.rpratrm_aidy_code 
  and rprawrd_fund_code = h.rpratrm_fund_code 
  and h.rpratrm_period = '20' || (to_number(substr(rprawrd_aidy_code, 0, 2)) - 1) || '30' 
left join rpratrm f 
  on rprawrd_pidm = f.rpratrm_pidm 
  and rprawrd_aidy_code = f.rpratrm_aidy_code 
  and rprawrd_fund_code = f.rpratrm_fund_code 
  and f.rpratrm_period = '20' || substr(rprawrd_aidy_code, 0, 2) || '10' 
left join rpratrm s 
  on rprawrd_pidm = s.rpratrm_pidm 
  and rprawrd_aidy_code = s.rpratrm_aidy_code 
  and rprawrd_fund_code = s.rpratrm_fund_code 
  and s.rpratrm_period = '20' || substr(rprawrd_aidy_code, 0, 2) || '20' 
left join rpratrm t 
  on rprawrd_pidm = t.rpratrm_pidm 
  and rprawrd_aidy_code = t.rpratrm_aidy_code 
  and rprawrd_fund_code = t.rpratrm_fund_code 
  and t.rpratrm_period = '20' || substr(rprawrd_aidy_code, 0, 2) || '30' 
where rprawrd_aidy_code = :AIDY 
  and rprawrd_pidm = :PIDM
