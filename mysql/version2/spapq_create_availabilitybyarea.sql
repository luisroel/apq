drop procedure if exists `spapq_create_availabilitybyarea`;
delimiter $$
create procedure `spapq_create_availabilitybyarea`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_availabilitybyarea` `as` where `as`.`idruntime` = idruntime) then
		delete from `apq_availabilitybyarea` where `idruntime` = idruntime;
	end if;

	insert into `apq_availabilitybyarea`
	select
		  `vl`.`idruntime`
		, `qp`.`area`
		, `qp`.`numequipments`
		, `vl`.`working` * `qp`.`numequipments` as `working`
		, `vl`.`break` * `qp`.`numequipments`	as `break`
		, `vl`.`off` * `qp`.`numequipments`		as `off`
	from (
		select
			  `av`.`idruntime`
			, sum(`av`.`working`)	as `working`
			, sum(`av`.`break`)		as `break`
			, sum(`av`.`off`)		as `off`
		from
			`apq_availability` `av`
		group by
			`av`.`idruntime`
	) `vl`
	inner join (
		select
			  `eq`.`idruntime`
			, `eq`.`area`
			, count(*)				as `numequipments`
		from
			`apq_equipment` `eq`
		group by
			  `eq`.`idruntime`
			, `eq`.`area`
	) `qp` on
		`qp`.`idruntime` = `vl`.`idruntime`
	where
		`vl`.`idruntime` = idruntime;
end;
$$
delimiter ;


