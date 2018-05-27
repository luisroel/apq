drop procedure if exists `spapq_rpt_apqbyequipment`;
delimiter $$
create procedure `spapq_rpt_apqbyequipment`(
	  idruntime		bigint
	, area			int
	, line			int
	, idequipment	varchar(20)
)
begin
	if idruntime = -1 then
		if area = 0 then 
			if line = 0	then			
				if idequipment = '' or idequipment = '%' then			-- ALL
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime = -1, area = 0,  line = 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
						and `nd`.`idequipment` = idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			else 
				if idequipment = '' or idequipment = '%' then			-- idruntime = -1, area = 0,  line <> 0, idequipment = 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
						and `nd`.`line` = line
					order by
							`dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime = -1, area = 0,  line <> 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
						and `nd`.`line`			= line
						and `nd`.`idequipment`	= idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			end if;
		else 
			if line = 0 then
				if idequipment = '' or idequipment = '%' then			-- idruntime = -1, area <> 0,  line = 0, idequipment = 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
						and `nd`.`area`	= area
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime = -1, area <> 0,  line = 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
						and `nd`.`area`			= area
						and `nd`.`idequipment`	= idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			else 
				if idequipment = '' or idequipment = '%' then			-- idruntime = -1, area <> 0,  line <> 0, idequipment = 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
						and `nd`.`area`	= area
						and `nd`.`line`	= line
					order by
							`dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime = -1, area <> 0,  line <> 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
						and `nd`.`area`			= area
						and `nd`.`line`			= line
						and `nd`.`idequipment`	= idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			end if;
		end if;
	else 
		if area = 0 then
			if line = 0 then
				if idequipment = '' or idequipment = '%' then			-- idruntime <> -1, area = 0,  line = 0, idequipment = 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
						`nd`.`idruntime`	= idruntime
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime <> -1, area = 0,  line = 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
							`nd`.`idruntime`	= idruntime
						and `nd`.`idequipment`	= idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			else
				if idequipment = '' or idequipment = '%' then			-- idruntime <> -1, area = 0,  line <> 0, idequipment = 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
							`nd`.`idruntime`	= idruntime
						and `nd`.`line`			= line
					order by
							`dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime <> -1, area = 0,  line <> 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
							`nd`.`idruntime`	= idruntime
						and `nd`.`line`			= line
						and `nd`.`idequipment`	= idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			end if;
		else 
			if line = 0	then				
				if idequipment = '' or idequipment = '%' then			-- idruntime <> -1, area <> 0,  line = 0, idequipment = 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
							`nd`.`idruntime`	= idruntime
						and `nd`.`area`			= area
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime <> -1, area <> 0,  line = 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
							`nd`.`idruntime`	= idruntime
						and `nd`.`area`			= area
						and `nd`.`idequipment`	= idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			else 
				if idequipment = '' or idequipment = '%' then			-- idruntime <> -1, area <> 0,  line <> 0, idequipment = 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
							`nd`.`idruntime`	= idruntime
						and `nd`.`area`			= area
						and `nd`.`line`			= line
					order by
							`dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				else													-- idruntime <> -1, area <> 0,  line <> 0, idequipment <> 0
					select
						*
					from
						`v_apq_get_fields_level5byequipment` `nd`
						inner join `v_apq_get_datachartbyequipment` `dc` on
								`dc`.`idruntime`	= `nd`.`idruntime`
							and `dc`.`area`			= `nd`.`area`
							and `dc`.`line`			= `nd`.`line`
							and `dc`.`idequipment`	= `nd`.`idequipment`
					where
							`nd`.`idruntime`	= idruntime
						and `nd`.`area`			= area
						and `nd`.`line`			= line
						and `nd`.`idequipment`	= idequipment
					order by
						  `dc`.`area`
						, `dc`.`line`
						, `dc`.`idequipment`
						, `dc`.`title`
						, `dc`.`pos`;
				end if;
			end if;
		end if;
	end if;
end;
$$
delimiter ;


