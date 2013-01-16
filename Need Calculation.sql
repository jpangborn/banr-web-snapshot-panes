-- PCNC - Current Aid Year Need Info
-- Displays the Need Calculation

-- Sequence: 1
-- Columns: 1

select to_char(nvl(rnvand0_budget_amount, 0), '$999,990') as "Budget", 
  to_char(nvl(rnvand0_efc_amt, 0), '$999,990') as "EFC", 
  to_char(nvl(rnvand0_gross_need, 0), '$999,990') as "Gross Need", 
  to_char(nvl(rnvand0_offer_amt, 0), '$999,990') as "Total Aid", 
  to_char(nvl(rnvand0_unmet_need, 0), '$999,990') as "Unmet Need" 
from rnvand0 
where rnvand0_aidy_code = :AIDY 
  and rnvand0_pidm = :PIDM