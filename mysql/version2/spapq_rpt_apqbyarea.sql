drop procedure if exists `spapq_rpt_apqbyarea`;
delimiter $$
create procedure `spapq_rpt_apqbyarea`(
		idruntime	bigint
	,	area		int
)
begin
	if idruntime < 1 then	-- latest run
		if area < 1 then
			select
				*
			from
				`v_apq_get_fields_level4byarea` `nd`
				inner join `v_apq_get_datachartbyarea` `dc` on
						`dc`.`idruntime`	= `nd`.`idruntime`
					and `dc`.`area`			= `nd`.`area`
			where
				`nd`.`idruntime` in (
					select max(`idruntime`) from `apq_runtime`
				)
			order by
				  `dc`.`area`
				, `dc`.`title`
				, `dc`.`pos`;
		else
			select
				*
			from
				`v_apq_get_fields_level4byarea` `nd`
				inner join `v_apq_get_datachartbyarea` `dc` on
						`dc`.`idruntime`	= `nd`.`idruntime`
					and `dc`.`area`			= `nd`.`area`
			where
					`nd`.`idruntime` in (
						select max(`idruntime`) from `apq_runtime`
					)
				and `nd`.`area`	= area
			order by
				  `dc`.`area`
				, `dc`.`title`
				, `dc`.`pos`;
		end if;
	else
		if area < 1 then
			select
				*
			from
				`v_apq_get_fields_level4byarea` `nd`
				inner join `v_apq_get_datachartbyarea` `dc` on
						`dc`.`idruntime`	= `nd`.`idruntime`
					and `dc`.`area`			= `nd`.`area`
			where
				`nd`.`idruntime` = idruntime
			order by
				  `dc`.`area`
				, `dc`.`title`
				, `dc`.`pos`;
		else
			select
				*
			from
				`v_apq_get_fields_level4byarea` `nd`
				inner join `v_apq_get_datachartbyarea` `dc` on
						`dc`.`idruntime`	= `nd`.`idruntime`
					and `dc`.`area`			= `nd`.`area`
			where
					`nd`.`idruntime`	= idruntime
				and `nd`.`area`			= area
			order by
				  `dc`.`area`
				, `dc`.`title`
				, `dc`.`pos`;
		end if;
	end if;
end;
$$
delimiter ;


