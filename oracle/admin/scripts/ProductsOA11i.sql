select
 substr(bug_number,1,10) BUG,
 decode(bug_number,
 '1581138','11i.HZ.A',
 '1586130','11i.HZ.B',
 '1697181','11i.HZ.C',
 '1808048','11i.HZ.D',
 '1886227','11i.HZ.E',
 '1921951','11i.HZ.F',
 '2111967','11i.HZ.G',
 '2116159','11i.HZ.H',
 '2239222','11i.HZ.I',
 '2665766','11i.HZ.I ROLLUP',
 '2488745','11i.HZ.J',
 '3006901','11i.HZ.J ROLLUP V1 (10.01)',
 '3085060','11i.HZ.J ROLLUP V2 (10.02) - Not Distributed',
 '2790616','11i.HZ.K',
 '3046602','11i.HZ.K ROLLUP V1 (11.01)',
 '3135919','11i.HZ.K ROLLUP V2 (11.02)',
 '3178291','11i.HZ.K ROLLUP V3 (11.03)',
 '3036401','11i.HZ.L',
 '3209839','11i.HZ.L ROLLUP V1 (12.01)',
 '3295400','11i.HZ.L ROLLUP V2 (12.02)',
 '3151672','11i.HZ.M',
 '3931579','11i.HZ.M ROLLUP V1 (13.01)',
 '4515906','11i.HZ.M ROLLUP V2 (13.02) - Not Distributed',
 '3618299','11i.HZ.N',
 '2201671','11i.IMC.A',
 '2396751','11i.IMC.B',
 '2667549','11i.IMC.C',
 '2751066','11i.IMC.D',
 '2767047','11i.IMC.E',
 '2767053','11i.IMC.F',
 '2767055','11i.IMC.G',
 '2767060','11i.IMC.H',
 '2767062','11i.IMC.I',
 '2767066','11i.IMC.J',
 '3161885','11i.IMC.K',
 '3284214','11i.IMC.L',
 '3931585','11i.IMC.L ROLLUP V1 (12.01)',
 '4017594','11i.IMC.M',
 '3391365','11i.OCM.A',
 '3658711','11i.OCM.A ROLLUP V1',
 '3373464','11i.OCM.B',
 '3751219','11i.OCM.B ROLLUP V1',
 '3620763','11i.OCM.C',
 '4594570','11i.OCM.D',
 '5136003','11i.OCM.D ROLLUP V1',
 '1338891','11i.AR.A',
 '1393884','11i.AR.B',
 '1403734','11i.AR.C',
 '1529296','11i.AR.D',
 '1608938','11i.AR.E',
 '1763786','11i.AR.F',
 '1966026','11i.AR.G',
 '1991140','11i.AR.H',
 '2100663','11i.AR.I',
 '2182030','11i.AR.J',
 '2396506','11i.AR.K',
 '2488726','11i.AR.L',
 '2864959','11i.AR.M',
 '3140000','11i.AR.M',
 '3151465','11i.AR.N',
 '3617855','11i.AR.O',
 '4299703','11i.AR.P',
 '2278688','11i.FWK V5.6E',
 '2378544','11i.FWK V5.7A',
 '2487130','11i.FWK V5.7B',
 '2592153','11i.FWK V5.7C',
 '2625063','11i.FWK V5.7D',
 '2656744','11i.FWK V5.7E',
 '2673156','11i.FWK V5.7F',
 '2708487','11i.FWK V5.7G',
 '3262919','11i.FWK.H',
 '2771817','11i.FWK 5.7H',
 '3162988','11i.FWK 5.7H-V5',
 '3484474','11i.FWK 5.7H-V6',
 '3671463','11i.FWK 5.7H-V6+',
 '3896348','11i.FWK 5.10 RUP1',
 '3875569','11i.FWK 5.10',
 '3771659','11i.FWK 5.10K',
 '1802898','TAX PATCH 16',
 '1845018','TAX PATCH 17',
 '1902355','TAX PATCH 18',
 '1911323','TAX PATCH 19',
 '1935832','TAX PATCH 20',
 '1964971','TAX PATCH 21',
 '1974712','TAX PATCH 22',
 '1993886','TAX PATCH 23',
 '2022252','TAX PATCH 24',
 '2116152','TAX PATCH 25',
 '2224651','TAX PATCH 26',
 '2325618','TAX PATCH 27',
 '2327902','TAX PATCH 27',
 '2459293','TAX PATCH 28',
 '2515759','TAX PATCH 29',
 '2975635','TAX PATCH 30',
 '3063288','TAX PATCH 31',
 '3453908','TAX PATCH 32',
 '3883422','TAX PATCH 33',
 '4218015','TAX PATCH 34',
 '5200052','TAX PATCH 35',
 '5335498','CONS. TAX PATCH FOR 11.5.x - Obs',
 '5578834','CONS. TAX PATCH FOR 11.5.3 - 11.5.9',
 '3126422','11.5.9 - CU1',
 '3171663','11.5.9 - CU2',
 '3140000','11.5.10 - Baseline',
 '3240000','11.5.10 - CU1',
 '3460000','11.5.10 - CU2',
 '3640000','11.5.10.1 - Main. Pack',
 '3480000','11.5.10.2 - Main. Pack',
 '3653484','11i.FIN_PF.G',
 '3153675','11i.FIN_PF.F',
 '2842697','11i.FIN_PF.E',
 '2629235','11i.FIN_PF.D',
 '3016445','11i.FIN_PF.D.1',
 '2380068','11i.FIN_PF.C',
 '2218339','11i.FIN_PF.B',
 '1807809','11i.FIN_PF.A'
) PATCH,
 creation_date App_date
from ad_bugs
 where bug_number in ('1581138','1586130','1697181','1808048','1886227','1921951','2111967',
                      '2116159','2239222','2665766','2488745','3006901','3085060','2790616',
                      '3046602','3135919','3178291','3036401','3209839','3295400','3151672',
                      '3151672','2201671','2396751','2667549','2751066','2767047','3618299',
                      '2767053','2767055','2767060','2767062','2767066','3161885','5335498',
                      '3284214','4017594','3391365','3373464','3620763','3658711','3931579',
                      '2771817','3262919','3162988','3484474','3671463','3896348','3875569',
                      '3771659','3617855','1338891','1393884','1403734','1529296','1608938',
                      '1763786','1966026','1991140','2100663','2182030','2396506','2488726',
                      '2864959','3151465','3751219','4218015','3931585','5200052','3640000',
                      '3883422','3453908','3063288','2975635','2515759','2459293','2327902',
                      '2325618','2224651','2116152','2022252','1993886','1974712','1964971',
                      '1935832','1911323','1902355','1845018','1802898','4515906','4594570',
                      '3126422','3171663','3240000','4299703','3460000','3140000','3480000',
                      '3653484','3153675','2842697','2629235',
                      '3016445','2380068','2218339','1807809','5578834','5136003','2278688',
                      '2378544','2487130','2592153','2625063','2656744','2673156','2708487'
)
order by 2
/