-- RJCT - Financial Aid Disbursement Errors
-- Displays and Memo or Disbursement Edit Messages for the Student

-- Sequence: 1
-- Columns: 0

select rprrslt_period as "Term", 
  decode(rprrslt_reject_type, 'D', 'Disbursement', 
                              'M', 'Memo') as "Reject Type", 
  rprrslt_fund_code || ' - ' || rfrbase_fund_title as "Fund", 
  rprrslt_reject_code || ' - ' || rtvrjct_desc as "Error", 
  rprrslt_activity_date as "Updated" 
from rprrslt 
left join rtvrjct 
  on rprrslt_reject_type = rtvrjct_type 
  and rprrslt_reject_code = rtvrjct_code 
left join rfrbase 
  on rprrslt_fund_code = rfrbase_fund_code 
where rprrslt_aidy_code = :AIDY 
  and rprrslt_pidm = :PIDM 
order by rprrslt_period, rprrslt_reject_type, rfrbase_print_seq_no