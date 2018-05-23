drop procedure if exists `spapq_rpt_equipment`;
delimiter $$
create procedure `spapq_rpt_equipment`(
	  idruntime	bigint
	, area		int
	, line		int
	, idequipment	varchar(30)
)
begin
	if area = 0 then
		if line = 0 then
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
					`av`.`idruntime` = idruntime;
			else
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
						`av`.`idruntime`	= idruntime
					and `av`.`idequipment`	= idequipment;
			end if;
		else 
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
						`av`.`idruntime`	= idruntime
					and `av`.`line`			= line;
			else
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
						`av`.`idruntime`	= idruntime
					and `av`.`line`			= line
					and `av`.`idequipment`	= idequipment;
			end if;
		end if;
	else 
		if line = 0 then
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
						`av`.`idruntime`	= idruntime
					and `av`.`area`			= area;
			else
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
						`av`.`idruntime`	= idruntime
					and `av`.`area`			= area
					and `av`.`idequipment`	= idequipment;
			end if;
		else 
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
						`av`.`idruntime`	= idruntime
					and `av`.`area`			= area
					and `av`.`line`			= line;
			else
				select
					*
				from
					`apq_equipment` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
				where
						`av`.`idruntime`	= idruntime
					and `av`.`area`			= area
					and `av`.`line`			= line
					and `av`.`idequipment`	= idequipment;
			end if;
		end if;
	end if;
end;
$$
delimiter ;

