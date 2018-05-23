drop procedure if exists `spapq_create_prodtimesbyarea`;
delimiter $$
create procedure `spapq_create_prodtimesbyarea`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_prodtimesbyarea` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_prodtimesbyarea` where `idruntime` = idruntime;
	end if;
    
	insert into `apq_prodtimesbyarea`
	select
	 	  `ct`.`idruntime`
		, `eq`.`area`
		, sum(`ct`.`time`)
	from
		`apq_prodtimes` `ct`
		left join `apq_equipment` `eq` on
			`eq`.`idequipment` = `ct`.`idequipment`
	where
		`ct`.`idruntime` = idruntime
	group by
		  `ct`.`idruntime`
		, `eq`.`area`;
end;
$$
delimiter ;
