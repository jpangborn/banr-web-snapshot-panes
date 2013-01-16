-- PCAW - Current Aid Year Award
-- Displays a list of the student's financial aid award for the aid year.

-- Sequence: 1
-- Columns: 0

select rprawrd_fund_code || ' - ' || rfrbase_fund_title as "Fund", 
  rprawrd_awst_code as "Status", 
  to_char(nvl(rprawrd_offer_amt, 0), '$999,990') as "Offered", 
  to_char(nvl(rprawrd_accept_amt, 0), '$999,990') as "Accepted" 
from rprawrd
left join rfrbase
  on rprawrd_fund_code = rfrbase_fund_code 
where rprawrd_aidy_code = :AIDY 
  and rprawrd_pidm = :PIDM 
order by rfrbase_print_seq_no