drop procedure if exists `spapq_create_prodtimessummary`;
delimiter $$
create procedure `spapq_create_prodtimessummary`(
	idruntime	bigint
)
begin
	if exists(select * from `apq_prodtimessummary` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_prodtimessummary` where `idruntime` = idruntime;
	end if;

	insert into `apq_prodtimessummary`
	select
	 	  `ct`.`idruntime`
		, sum(`ct`.`time`)
	from
		`apq_prodtimes` `ct`
	where
		`ct`.`idruntime` = idruntime
	group by
		`ct`.`idruntime`;
end;
$$
delimiter $$
