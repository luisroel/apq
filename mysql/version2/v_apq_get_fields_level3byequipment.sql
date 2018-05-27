drop view if exists `v_apq_get_fields_level3byequipment`;
create view `v_apq_get_fields_level3byequipment`
as
	select
		  `vl`.*
		, `vl`.`planned_production_time` - `vl`.`stop_time` as `runtime`
	from
		`v_apq_get_fields_level2byequipment` `vl`;
