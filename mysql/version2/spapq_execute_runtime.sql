drop procedure if exists `spapq_execute_runtime`;
delimiter $$
create procedure `spapq_execute_runtime`(
	idruntime	bigint
)
begin

	-- delete families numbers
	call `spapq_pack_prodtimes`( idruntime );

	-- By Summary
	call `spapq_create_equipmentsummary`( idruntime  );
	call `spapq_create_availabilitysummary`( idruntime );
	call `spapq_create_prodtimessummary`( idruntime );
	call `spapq_create_stopssummary`( idruntime );
	call `spapq_create_countssummary`( idruntime );
	call `spapq_create_setupandstartsummary`( idruntime );

	-- By Area
	call `spapq_create_equipmentbyarea`( idruntime );
	call `spapq_create_availabilitybyarea`( idruntime );
	call `spapq_create_prodtimesbyarea`( idruntime );
	call `spapq_create_stopsbyarea`( idruntime );
	call `spapq_create_countsbyarea`( idruntime );
	call `spapq_create_setupandstartbyarea`( idruntime );

	-- By Line
	call `spapq_create_equipmentbyline`( idruntime );
	call `spapq_create_availabilitybyline`( idruntime );
	call `spapq_create_prodtimesbyline`( idruntime );
	call `spapq_create_stopsbyline`( idruntime );
	call `spapq_create_countsbyline`( idruntime );
	call `spapq_create_setupandstartbyline`( idruntime );

	-- By Equipment
	call `spapq_create_stopsbyequipment`( idruntime );
	call `spapq_create_countsbyequipment`( idruntime );
	call `spapq_create_prodtimesbyequipment`( idruntime );
	call `spapq_create_setupandstartbyequipment`( idruntime );
    

end;
$$
delimiter ;
