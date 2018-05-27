drop procedure if exists `spapq_create_prodtimesbyline`;
delimiter $$
create procedure `spapq_create_prodtimesbyline`(
	idruntime	bigint
)
begin
	if exists (select * from `apq_prodtimesbyline` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_prodtimesbyline` where `idruntime` = idruntime;
	end if;
    
	insert into `apq_prodtimesbyline`
	select
	 	  `ct`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`
		, sum(`ct`.`time`)
	from
		`apq_prodtimes` `ct`
		left join `apq_equipment` `eq` on
			`eq`.`idequipment` = `ct`.`idequipment`
	where
		`ct`.`idruntime` = idruntime
	group by
		  `ct`.`idruntime`
		, `eq`.`area`
		, `eq`.`line`;
end;
$$
delimiter ;
