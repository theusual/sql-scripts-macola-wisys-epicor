/*Cross References for all item locations when orders are integrated via EDI*/

/*EDI Item Cross Reference*/
SELECT lit_default_loc_1, *
FROM edcitmfl_sql
WHERE mac_item_num = 'VEG-39 B-BK'

/*EDI Trading Partner Cross Reference*/
SELECT lit_default_loc_1, *
FROM EDCTP_FL_SQL

/*Alternate Address Cross Reference*/
SELECT loc, *
FROM araltadr_sql

/*Customer File*/
SELECT loc, *
FROM arcusfil_sql
WHERE cus_no like '%1575%'

/*Item Master*/
SELECT loc, *
FROM imitmidx_sql
WHERE loc = 'NE'

/*Update*/
UPDATE EDCTP_FL_SQL
SET lit_default_loc_1 = 'MDC'