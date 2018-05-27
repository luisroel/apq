drop view if exists `v_apq_get_fields_level4byline`;
create view `v_apq_get_fields_level4byline`
as
	select
		  `vl`.*
		, (`vl`.`runtime` / `vl`.`planned_production_time` )													as `ia_index`
		, (`vl`.`nom_setup_time` + `vl`.`nom_start_time` + `vl`.`nom_total_count_time`) / `vl`.`runtime` 	as `ip_index`
		, (`vl`.`good_count` / `vl`.`total_count`) 															as `iq_index`
	from
		`v_apq_get_fields_level3byline` `vl`;
