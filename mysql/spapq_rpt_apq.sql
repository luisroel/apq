
drop procedure if exists `spapq_rpt_apq`;
delimiter $$
create procedure `spapq_rpt_apq`(
	idruntime bigint
)
begin
	if idruntime = -1 then	-- latest run
		select
			*
		from
			`v_apq_get_index` `nd`
			inner join `v_apq_get_datachart` `dc` on
				`dc`.`idruntime` = `nd`.`idruntime`
		where
			`nd`.`idruntime` in (
				select max(`idruntime`) from `apq_runtime`
			)
		order by
			  `dc`.`title`
			, `dc`.`pos`;
	else
		select
			*
		from
			`v_apq_get_index` `nd`
			inner join `v_apq_get_datachart` `dc` on
				`dc`.`idruntime` = `nd`.`idruntime`
		where
			`nd`.`idruntime` = idruntime
		order by
			  `dc`.`title`
			, `dc`.`pos`;
	end if;
end;
$$
delimiter ;



