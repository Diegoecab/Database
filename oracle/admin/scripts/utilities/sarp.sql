-- ------------------------------------------------------------------------------
-- File       : sarp.sql
-- Purpose    : Oracle administration helper: sarp.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @sarp.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
select distinct ArticuloTemp1.IDARTICULO, 5 - ceil(to_number(trunc(sysdate) - VentaSucursal.Fecha)/7) as IdSemana, VentaSucursal.FECHA
from VentaSucursal, VentaSucursalItem,
TMPARTICULOVPD ArticuloTemp1
where VentaSucursalItem.IDVENTASUCURSAL = VentaSucursal.IDVENTASUCURSAL
and VentaSucursal.IDEMPRESA = &pIdEmpresa
and VentaSucursal.IDSUCURSAL = &pIdSucursal
and (VentaSucursalItem.IDARTICULO = ArticuloTemp1.IDARTICULO)
and VentaSucursal.FECHA between trunc(sysdate) -28 and trunc(sysdate) -1
and VentaSucursalItem.CANTIDAD > 0
and VentaSucursal.IDEMPRESA not in (select VentaNoComputable.IDEMPRESA from VentaNoComputable
                                where VentaNoComputable.IDEMPRESA = &pIdEmpresa
                                and VentaNoComputable.IDSUCURSAL IS NULL
                                and VentaNoComputable.IDARTICULO IS NULL
                                and VentaNoComputable.IDFAMILIA IS NULL
                                and VentaNoComputable.IDLINEA IS NULL
                                and VentaSucursal.FECHA between VentaNoComputable.FECHADESDE and VentaNoComputable.FECHAHASTA
                           )
and VentaSucursal.IDSUCURSAL not in (select VentaNoComputable.IDSUCURSAL from VentaNoComputable
                                where VentaNoComputable.IDEMPRESA = &pIdEmpresa
                                and VentaNoComputable.IDSUCURSAL IS NOT NULL
                                and VentaNoComputable.IDARTICULO IS NULL
                                and VentaNoComputable.IDFAMILIA IS NULL
                                and VentaNoComputable.IDLINEA IS NULL
                                and VentaSucursal.FECHA between VentaNoComputable.FECHADESDE and VentaNoComputable.FECHAHASTA
                            )
and ArticuloTemp1.IDARTICULO not in (select VentaNoComputable.IDARTICULO from VentaNoComputable
                                        where VentaNoComputable.IDEMPRESA = &pIdEmpresa
                                        and VentaNoComputable.IDFAMILIA IS NULL
                                        and VentaNoComputable.IDLINEA IS NULL
                                        and VentaNoComputable.IDARTICULO IS NOT NULL
                                        and (VentaNoComputable.IDSUCURSAL IS NULL or VentaNoComputable.IDSUCURSAL = &pIdSucursal)
                                        and VentaSucursal.FECHA between VentaNoComputable.FECHADESDE and VentaNoComputable.FECHAHASTA
                                    )
and ArticuloTemp1.IDFAMILIA not in (select VentaNoComputable.IDFAMILIA from VentaNoComputable
                                        where VentaNoComputable.IDEMPRESA = &pIdEmpresa
                                        and VentaNoComputable.IDFAMILIA IS NOT NULL
                                        and VentaNoComputable.IDLINEA IS NULL
                                        and VentaNoComputable.IDARTICULO IS NULL
                                        and (VentaNoComputable.IDSUCURSAL IS NULL or VentaNoComputable.IDSUCURSAL = &pIdSucursal)
                                        and VentaSucursal.FECHA between VentaNoComputable.FECHADESDE and VentaNoComputable.FECHAHASTA
                                   )
and ArticuloTemp1.IDLINEA not in (select VentaNoComputable.IDLINEA from VentaNoComputable
                                        where VentaNoComputable.IDEMPRESA = &pIdEmpresa
                                        and VentaNoComputable.IDFAMILIA IS NULL
                                        and VentaNoComputable.IDLINEA IS NOT NULL
                                        and VentaNoComputable.IDARTICULO IS NULL
                                        and (VentaNoComputable.IDSUCURSAL IS NULL or VentaNoComputable.IDSUCURSAL = &pIdSucursal)
                                        and VentaSucursal.FECHA between VentaNoComputable.FECHADESDE and VentaNoComputable.FECHAHASTA
                                   );