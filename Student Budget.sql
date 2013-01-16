-- BUDG - Student Budget
-- Displays a breakdown of the student budget. (For standard Aid Year budgets, not Period budgets.)

-- Sequence: 1
-- Columns: 0

select rbracmp_comp_code || ' - ' || rtvcomp_desc as "Component", 
  to_char(rbracmp_amt, '$999,990') as "Amount" 
from rbracmp 
left join rtvcomp 
  on rbracmp_comp_code = rtvcomp_code 
where rbracmp_btyp_code = 'CAMP' 
  and rbracmp_aidy_code = :AIDY 
  and rbracmp_pidm = :PIDM 
order by rtvcomp_print_seq_no

-- Sequence: 2
-- Columns: 1

select to_char(sum(rbracmp_amt), '$999,990') as "Total Budget" 
from rbracmp 
where rbracmp_btyp_code = 'CAMP' 
  and rbracmp_aidy_code = :AIDY 
  and rbracmp_pidm = :PIDM