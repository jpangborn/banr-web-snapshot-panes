Banner Web Snapshot Panes
=========================

Web Snapshot allows you to create customized layouts of data with just SQL. Think of it as a method to mashup just the data you want to see. A snapshot view is composed of any number of snapshot panes. Panes are simply one or more SQL statements. These example snapshot panes should help you get started with Web Snapshot. See my [Introduction to Web Snapshot](http://joshuapangborn.wordpress.com/2013/01/15/introduction-to-financial-aid-web-snapshot/#more-77) for more information on Web Snapshot

Example Panes
-------------

### Aid Year Award Pane

The Aid Year Award Pane displays a summary of the student's award for the aid year, including the fund title and the award amount. This pane was created for use in a Current Student Packaging layout that compared the previous year's award with the current year.

### Aid Year Holds Pane

The Aid Year Holds pane displays the student's holds for the aid year. It also displays any holds that have no aid year assigned.

### Aid Year Overview Pane

This pane shows an overview of the aid year processing, including the following fields:

- FAFSA Receipt Date
- Tracking Group
- Budget Group
- Packaging Group
- Aid Period
- Current SAP Status
- SAP Effective Term
- Package Requirements Complete Date
- Package Complete Date

### Disbursement Errors Pane

The Disbursement Errors pane displays any memo and disbursement errors for any periods in the aid year.

### Financial Aid Award by Term Pane

The Financial Aid Award by Term pane shows a breakdown of the student's financial aid for each term in the Aid Year. It also shows the annual total. A summary section is also included showing the term totals and the annual grand total.

### GPA Information Pane

The GPA Information pane displays data related to a student's GPA calculation including, Credit Hours Attempted, Credit Hours Earned, Cumulative GPA, Previous Year GPA, and Number of Terms the student has been full-time. This pane was created to assist is reviewing merit scholarship renewal.

### Need Calculation Pane

This pane displays the student's need calculation, including Cost of Attendance, Expected Family Contribution, Gross Need, Total Aid, and Unmet Need.

### Student Bill for Fall, Spring, or Summer Panes

The Student Bill panes display the student's account detail for the period and includes summary data. Display all three panes side by side to show an entire year's student account detail.

### Student Budget Pane

The Student Budget Pane shows the students budget for the aid year.

### Student Course Registration Pane

This panes displays the student's course registration for any term in the aid year.

### Student Holds Pane

The Student Holds pane shows any unreleased student holds. 

### Ten Most Recent Letters Pane

This pane shows the ten most recent letters sent to the student from the Financial Aid module.

### Tracking Requirements Pane

This pane shows all of the student's tracking requirements for the aid year.

Tips and Tricks
---------------

Below are some tips and tricks that are useful in writing snapshot panes.

### Term-based Panes

Web Snapshot have two dynamic parameters that can be used in the SQL statement, Aid Year (:AIDY) and Student's PIDM (:PIDM). Often, these aren't sufficient to build the panes that you want. One common issue is creating panes that show term based information. This can be accomplished with a LIKE clause. An example of selecting information from a Financial Aid table like RPRATRM is below.

#### Selecting Fall Data from RPRATRM

```sql
SELECT *
FROM rpratrm
WHERE rpratrm_aidy_code = :AIDY
  AND rpratrm_pidm = :PIDM
  AND rpratrm_period LIKE '%10'
```

This statement is based on the Fall term code being 201210. An example of this method is the Financial Aid Award by Term pane.

### Panes with Data from Tables without Aid Years

Selecting data from a table that does not contain an aid year is a bit more complicated. It can be accomplished by joining with STVTERM to get the terms in an aid year. An example of selecting data from tbraccd is below.

#### Selecting Term Data from TBRACCD

```sql
SELECT *
FROM tbraccd
LEFT JOIN stvterm
  ON tbraccd_term_code = stvterm_code
WHERE tbraccd_pidm = :PIDM
  AND stvterm_fa_proc_yr = :AIDY
```
This statement is return all student account data for the aid year. An example of this technique is the Student Course Registration pane.

Both of these techinques can be combined to get specific term data from a non aid year table. This can be seen in the Student Bill panes.

### Panes for different Aid Years

One of the layouts that I created required comparing data from the current aid year to the previous aid year. The following example will show how to select data from RPRAWRD.

#### Selecting Prior Aid Year data from RPRAWRD

```sql
SELECT *
FROM rprawrd
WHERE rprawrd_aidy_code = :AIDY - 101
 AND rprawrd_pidm = :PIDM
```
     
The Aid Year Award pane can be modified to display the previous aid year very easily.