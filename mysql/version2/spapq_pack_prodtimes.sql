drop procedure if exists `spapq_pack_prodtimes`;
delimiter $$
create procedure `spapq_pack_prodtimes`(
	idruntime	bigint
)
begin
	delete from `apq_prodtimes`
	where 
		`itemid` in ( 
			select 
				`af`.`brother`
			from 
				`apq_families` `af`
				inner join (
					select
						  `af`.`main`
                        , count(*) as `count`
					from 
						`apq_prodtimes` `ap` 
                        inner join `apq_families` `af` on
							`af`.`brother` = `ap`.`itemid` 
					group by
						`af`.`main`
					having 
						count(*) > 1
				) `tt` on 
					`tt`.`main` = `af`.`main`
			where
				`af`.`main` <> `af`.`brother`
		)
		and `idruntime` = idruntime;
end;
$$
delimiter $$
