-- BFAL - Student Bill - Fall
-- Displays the Student Account detail from Account Receivable for the Fall Term. Include a totals summary. 

-- Sequence: 1    
-- Columns: 0

select tbraccd_detail_code as "Detail Code", 
  rfrbase_fund_code as "Fund Code", 
  tbraccd_desc as "Description", 
  case tbbdetc_type_ind 
    when 'C' then to_char(tbraccd_amount, '$999,990.00') 
    when 'P' then to_char(tbraccd_amount * -1, '$999,990.00') 
  end as "Amount" 
from tbraccd 
left join tbbdetc 
  on tbraccd_detail_code = tbbdetc_detail_code 
left join stvterm 
  on tbraccd_term_code = stvterm_code 
left outer join rfrbase 
  on tbraccd_detail_code = rfrbase_detail_code 
where tbraccd_term_code like '%10' 
  and stvterm_fa_proc_yr = :AIDY 
  and tbraccd_pidm = :PIDM 
order by tbraccd_tran_number

-- Sequence: 2
-- Columns: 1

select to_char(sum(case tbbdetc_type_ind when 'C' then tbraccd_amount when 'P' then tbraccd_amount * -1 end), '$999,990.00') as "Prior Balance" 
from tbraccd 
left join tbbdetc 
  on tbraccd_detail_code = tbbdetc_detail_code 
where tbraccd_pidm = :PIDM 
  and tbraccd_term_code < (select stvterm_code from stvterm where stvterm_code like '%10' and stvterm_fa_proc_yr = :AIDY)
  
-- Sequence: 3
-- Columns: 1

select to_char(sum(case tbbdetc_type_ind when 'C' then tbraccd_amount else 0 end), '$999,990.00') as "Total Charges", 
  to_char(sum(case tbbdetc_type_ind when 'P' then tbraccd_amount else 0 end), '$999,990.00') as "Total Payments", 
  to_char(sum(case tbbdetc_type_ind when 'C' then tbraccd_amount when 'P' then tbraccd_amount * -1 end), '$999,990.00') as "Balance" 
from tbraccd 
left join tbbdetc 
  on tbraccd_detail_code = tbbdetc_detail_code 
left join stvterm 
  on tbraccd_term_code = stvterm_code 
where tbraccd_term_code like '%10' 
  and stvterm_fa_proc_yr = :AIDY 
  and tbraccd_pidm = :PIDM 
group by tbraccd_term_code