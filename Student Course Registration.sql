-- REGS - Student Course Registration
-- Displays the Student's Course Regisration for any terms in the Aid Year

-- Sequence: 1
-- Columns: 0

select sfrstcr_term_code as "Term", 
  ssbsect_subj_code || ' - ' || ssbsect_crse_numb as "Course", 
  sfrstcr_crn as "CRN", 
  ssbsect_ptrm_start_date || ' - ' || ssbsect_ptrm_end_date as "Course Dates", 
  sfrstcr_gmod_code as "Grade Mode", 
  sfrstcr_credit_hr as "Credit Hours", 
  sfrstcr_bill_hr as "Bill Hours", 
  sfrstcr_rsts_code as "Status" 
from sfrstcr 
left join ssbsect 
  on sfrstcr_term_code = ssbsect_term_code 
  and sfrstcr_crn = ssbsect_crn 
left join stvterm 
  on sfrstcr_term_code = stvterm_code 
where stvterm_fa_proc_yr = :AIDY 
  and sfrstcr_pidm = :PIDM 
order by sfrstcr_term_code, "Course"