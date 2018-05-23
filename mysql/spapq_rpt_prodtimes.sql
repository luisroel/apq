drop procedure if exists `spapq_rpt_prodtimes`;
delimiter $$
create procedure `spapq_rpt_prodtimes`(
	  idruntime		bigint
	, area			int
	, line			int
	, idequipment	varchar(30)
)
begin
	if area = 0 then
		if line = 0 then
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
					`av`.`idruntime` = idruntime;
			else
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
						`av`.`idruntime` 	= idruntime
					and `av`.`idequipment`	= idequipment;
			end if;
		else 
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
					`av`.`idruntime` = idruntime
				and `eq`.`line`		= line;
			else
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
						`av`.`idruntime`	= idruntime
					and `eq`.`line`			= line
					and `av`.`idequipment`	= idequipment;
			end if;
		end if;
	else
		if line = 0 then
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
						`av`.`idruntime`	= idruntime
					and `eq`.`area`			= area;
			else
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
						`av`.`idruntime`	= idruntime
					and `eq`.`area`			= area
					and `av`.`idequipment`	= idequipment;
			end if;
		else 
			if idequipment = '' or idequipment = '%' then
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
						`av`.`idruntime`	= idruntime
					and `eq`.`area`			= area
					and `eq`.`line`			= line;
			else
				select
					*
				from
					`apq_prodtimes` `av`
					inner join `apq_runtime` `rt` on
						`rt`.`idruntime` = `av`.`idruntime`
					left join `apq_equipment` `eq` on
							`eq`.`idruntime` = `av`.`idruntime`
						and `eq`.`idequipment` = `av`.`idequipment`
				where
						`av`.`idruntime`	= idruntime
					and `eq`.`area`			= area
					and `eq`.`line`			= line
					and `av`.`idequipment`	= idequipment;
			end if;
		end if;
	end if;
end;
$$
delimiter ;

