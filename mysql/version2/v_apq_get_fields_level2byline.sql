drop view if exists `v_apq_get_fields_level2byline`;
create view `v_apq_get_fields_level2byline`
as
	select
		  `vl`.*

		, `vl`.`time_for_production` - `vl`.`nom_production_time`	as `nom_iddle_time`
		, `vl`.`time_for_production` - `vl`.`act_production_time`	as `act_iddle_time`

		, (`vl`.`act_production_time` - `vl`.`nom_production_time`) as `performance_time_loss`
		, `vl`.`nom_production_time` 								as `performance_time`
		, `vl`.`act_production_time`								as `performance_total`
	from
		`v_apq_get_fields_level1byline` `vl`;