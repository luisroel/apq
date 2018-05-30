
drop procedure if exists `spapq_rpt_apq`;
delimiter $$
create procedure `spapq_rpt_apq`(
	idruntime bigint
)
begin
	if idruntime = 0 then	-- latest run: review this beacuase it does not make sense
		select
			*
		from
			`v_apq_get_fields_level4` `nd`
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
			`v_apq_get_fields_level4` `nd`
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



