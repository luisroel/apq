drop procedure if exists `spapq_create_countssummary`;
delimiter $$
create procedure `spapq_create_countssummary`(
	  idruntime	bigint
)
begin
	if exists(select * from `apq_countssummary` `st` where `st`.`idruntime` = idruntime) then
		delete from `apq_countssummary` where `idruntime` = idruntime;
	end if;

	insert into `apq_countssummary`
	select
	 	  `idruntime`
		, sum(`ct`.`goodcount`)
		, sum(`ct`.`badcount`)
		, sum(`ct`.`totalcount`)
		, sum(`ct`.`goodtime`)
		, sum(`ct`.`losstime`)
		, sum(`ct`.`totaltime`)
	from
		`apq_counts` `ct`
	where
		`ct`.`idruntime` = idruntime;
end;
$$
delimiter ;

