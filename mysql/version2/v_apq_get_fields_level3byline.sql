drop view if exists `v_apq_get_fields_level3byline`;
create view `v_apq_get_fields_level3byline`
as
	select
		  `vl`.*
		, `vl`.`planned_production_time` - `vl`.`stop_time` as `runtime`
	from
		`v_apq_get_fields_level2byline` `vl`;
