set linesize 300
set pagesize 100
col NOMBRE_WORKBOOK format a100

select c.scd_surrgt_pk, c.scd_ins_surrgt_fk, COUNT(a.cch_url) cant_work,
MIN(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5,instr(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5),']') -1)) nombre_workbook,
max(scd_last_updated) max_scd_last_update,
max(scd_next_update) max_scd_next_update,
max(a.cch_last_updated) max_cch_last_updated
FROM discoverer5.ptm5_cache a, DISCOVERER5.PTM5_SCHEDULE c
WHERE a.cch_ins_surrgt_fk = c.scd_ins_surrgt_fk
GROUP BY c.scd_surrgt_pk, c.scd_ins_surrgt_fk
-- ORDER BY max_scd_last_update,max_scd_next_update,
-- MIN(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5,instr(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5),']') -1))
order by max_cch_last_updated
/


SELECT scd.scd_last_updated, scd.scd_next_update, ins.ins_id, plt.plt_id_uk, ptn.ptn_id_uk 
FROM discoverer5.ptm5_schedule scd, discoverer5.ptm5_instance ins, discoverer5.ptm5_portlet plt, discoverer5.ptm5_partition ptn 
WHERE scd.scd_next_update = (SELECT MIN(scd_next_update) FROM discoverer5.ptm5_schedule) 
AND ins.ins_surrgt_pk = scd.scd_ins_surrgt_fk 
AND plt.plt_surrgt_pk = ins.ins_plt_surrgt_fk 
AND ptn.ptn_surrgt_pk = ins.ins_ptn_surrgt_fk
/


select c.scd_surrgt_pk, c.scd_ins_surrgt_fk, COUNT(a.cch_url) cant_work,
MIN(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5,instr(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5),']') -1)) nombre_workbook,
max(scd_last_updated) max_scd_last_update,
max(scd_next_update) max_scd_next_update,
max(a.cch_last_updated) max_cch_last_updated
FROM discoverer5.ptm5_cache a, DISCOVERER5.PTM5_SCHEDULE c
WHERE a.cch_ins_surrgt_fk = c.scd_ins_surrgt_fk
and a.cch_ins_surrgt_fk= 
SELECT ins.ins_ptn_surrgt_fk
FROM discoverer5.ptm5_schedule scd, discoverer5.ptm5_instance ins, discoverer5.ptm5_portlet plt, discoverer5.ptm5_partition ptn 
WHERE scd.scd_next_update = (SELECT MIN(scd_next_update) FROM discoverer5.ptm5_schedule) 
AND ins.ins_surrgt_pk = scd.scd_ins_surrgt_fk 
AND plt.plt_surrgt_pk = ins.ins_plt_surrgt_fk 
AND ptn.ptn_surrgt_pk = ins.ins_ptn_surrgt_fk)
GROUP BY c.scd_surrgt_pk, c.scd_ins_surrgt_fk
ORDER BY max_scd_last_update,max_scd_next_update,
MIN(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5,instr(substr(a.CCH_URL,instr(a.CCH_URL,'wb_k=')+5),']') -1))
/


SELECT min(a.cch_last_updated),max(a.cch_last_updated), 
min(a.cch_next_update),max(a.cch_next_update),min(a.cch_type),max(a.cch_type),
min(a.cch_ins_surrgt_fk),max(a.cch_ins_surrgt_fk),
min(a.cch_immed_refresh),max(a.cch_immed_refresh),  
min(a.cch_sched_refresh), max(a.cch_sched_refresh)
FROM discoverer5.ptm5_cache a
ORDER BY a.cch_last_updated ASC
/