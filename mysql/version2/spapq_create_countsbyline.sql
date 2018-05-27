drop procedure if exists `spapq_create_countsbyline`;
delimiter $$
create procedure `spapq_create_countsbyline`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_countsbyline` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_countsbyline` where `idruntime` = idruntime;
	end if;

	insert into `apq_countsbyline`
	select
	 	  idruntime
		, `eq`.`area`
		, `eq`.`line`
		, SUM(`ct`.`goodcount`)
		, SUM(`ct`.`badcount`)
		, SUM(`ct`.`totalcount`)
		, SUM(`ct`.`goodtime`)  / 60.0
		, SUM(`ct`.`losstime`) / 60.0
		, SUM(`ct`.`totaltime`) / 60.0
	FROM
		`apq_counts` `ct`
		inner join `apq_equipment` `eq` on
			`eq`.`idequipment` = `ct`.`idequipment`
	where
		`ct`.`idruntime` = idruntime
	group by
		  `eq`.`area`
		, `eq`.`line`;
end;
$$
delimiter ;
