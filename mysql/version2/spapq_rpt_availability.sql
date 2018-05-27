drop procedure if exists `spapq_rpt_availability`;
delimiter $$
create procedure `spapq_rpt_availability`(
	    idruntime	bigint
	  , area		int
	  , line		int
	  , idequipment	varchar(30)
)
begin
	select
		*
	from
		`apq_availability` `av`
		inner join `apq_runtime` `rt` on
			`rt`.`idruntime` = `av`.`idruntime`
	where 
		`av`.`idruntime` = idruntime;
end;
$$

