drop procedure if exists `spapq_create_availability`;
delimiter $$
create procedure `spapq_create_availability`(
	  idruntime	bigint
	, fromdate	datetime
	, todate	datetime
)
begin
	-- Delete previuos records
	delete from `apq_availability` where `idruntime` = idruntime;

	set @current_date = fromdate;
	while @current_date <= todate do

		set @day_of_week = weekday(@current_date);
        if @day_of_week = 6 then
			set @day_of_week = 1;
		else
			set @day_of_week = @day_of_week + 2;
		end if;

		set @working	= 0;
		set @days_off	= 0;
		set @break		= 0;
		if exists(select * from `apq_scheduletemplate` `st` where `st`.`dayofweek` = @day_of_week) then
			select
				  `st`.`working`
				, `st`.`off`
				, `st`.`break`
                into 
                  @working
                , @days_off
                , @break
			from
				`apq_scheduletemplate` `st`
			where
				`st`.`dayofweek` = @day_of_week;
		end if;

		insert into `apq_availability`(`idruntime`, `date`, `dayofweek`, `working`, `off`, `break`) values (idruntime, @current_date, @day_of_week, @working, @days_off, @break);
		set @current_date = date_add(@current_date, interval 1 day);
	end while;
end;
$$
delimiter ;

