drop view if exists `v_apq_get_fields_level2byline`;
create view `v_apq_get_fields_level2byline`
as
	select
			`vl`.*
		  , `vl`.`time_for_production` - `vl`.`nom_iddle_time` as `planned_production_time`
	from
		`v_apq_get_fields_level1byline` `vl`;