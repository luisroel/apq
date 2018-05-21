drop procedure if exists `spapq_rpt_apqbyline`;
delimiter $$
create procedure `spapq_rpt_apqbyline`(
	  idruntime	bigint
	, area		int
	, line		int
)
begin
	if idruntime = -1 then				-- Latest run
		if area = 0 then
			if line = 0	then			-- all
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime` 	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
					`nd`.`idruntime` in (
						select max(`idruntime`) from `apq_runtime`
					)
				order by
					  `dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			else					-- idruntime = -1, area = 0,  line <> 0
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime`	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
					`nd`.`idruntime` in (
						select max(`idruntime`) from `apq_runtime`
					)
					and `nd`.`line`	= line
				order by
					  `dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			end if;
		else
			if line = 0 then			-- idruntime = -1, area <> 0,  line = 0
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime`	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
					`nd`.`idruntime` in (
						select max(`idruntime`) from `apq_runtime`
					)
					and `nd`.`area` = area
				order by
					  `dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			else						-- idruntime = -1, area <> 0,  line <> 0
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime`	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
						`nd`.`idruntime` in (
							select max(`idruntime`) from `apq_runtime`
						)
					and `nd`.`area`	= area
					and `nd`.`line`	= line
				order by
					  `dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			end if;
		end if;
	else
		if area = 0	then			
			if line = 0 then					-- idruntime <> -1, area = 0,  line = 0
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime`	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
					`nd`.`idruntime` = idruntime
				order by
						`dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			else							-- idruntime <> -1, area = 0,  line <> 0
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime`	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
						`nd`.`idruntime`	= idruntime
					and `nd`.`line`			= line
				order by
						`dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			end if;
		else
			if line = 0	then				-- idruntime <> -1, area <> 0,  line = 0
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime`	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
						`nd`.`idruntime` 	= idruntime
					and `nd`.`area` 		= area
				order by
						`dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			else								-- idruntime <> -1, area <> 0,  line <> 0
				select
					*
				from
					`v_apq_get_indexbyline` `nd`
					inner join `v_apq_get_datachartbyline` `dc` on
							`dc`.`idruntime`	= `nd`.`idruntime`
						and `dc`.`area`			= `nd`.`area`
						and `dc`.`line`			= `nd`.`line`
				where
						`nd`.`idruntime`	= idruntime
					and `nd`.`area`			= area
					and `nd`.`line`			= line
				order by
						`dc`.`area`
					, `dc`.`line`
					, `dc`.`title`
					, `dc`.`pos`;
			end if;
		end if;
	end if;
end;
$$
delimiter ;



