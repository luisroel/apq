drop view if exists `v_apq_get_fields_level3byline`;
create view `v_apq_get_fields_level3byline`
as
        select
                  `vl`.*

                , (`vl`.`availability_time` / `vl`.`availability_total` )       as `ia_index`
                , (`vl`.`performance_time` / `vl`.`performance_total`)          as `ip_index`
                , (`vl`.`good_count` / `vl`.`total_count`)                      as `iq_index`
        from
                `apq_runtime` `rt`
                inner join `v_apq_get_fields_level2byline` `vl` on
                        `rt`.`idruntime` = `vl`.`idruntime`;
