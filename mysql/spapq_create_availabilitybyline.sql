drop procedure if exists `spapq_create_availabilitybyline`;
delimiter $$
create procedure `spapq_create_availabilitybyline`(
	idruntime bigint
)
begin
	if exists(select * from `apq_availabilitybyline` `as` where `as`.`idruntime` = idruntime) then
		delete from `apq_availabilitybyline` where `idruntime` = idruntime;
	end if;

	insert into `apq_availabilitybyline`
	select
		  `vl`.`idruntime`
		, `qp`.`area`
		, `qp`.`line`
		, `qp`.`numequipments`
		, `vl`.`working` * `qp`.`numequipments` as `working`
		, `vl`.`break` * `qp`.`numequipments`	as `break`
		, `vl`.`off` * `qp`.`numequipments`		as `off`
	from (
		select
			  `eq`.`idruntime`
			, `eq`.`area`
			, `eq`.`line`
			, count(*)				as `numequipments`
		from
			`apq_equipment` `eq`
		group by
			  `eq`.`idruntime`
			, `eq`.`area`
			, `eq`.`line`
	) `qp`
	left join (
		select
			  `av`.`idruntime`
			, sum(`av`.`working`)	as `working`
			, sum(`av`.`break`)		as `break`
			, sum(`av`.`off`)		as `off`
		from
			`apq_availability` `av`
		group by
			`av`.`idruntime`
	) `vl` on
		`vl`.`idruntime` = `qp`.`idruntime`
	where
		`vl`.`idruntime` = idruntime;
end;
$$
delimiter ;



