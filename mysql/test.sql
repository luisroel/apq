
call `spapq_execute_runtime`('5/1/2017 00:00');

truncate table `apq_runtime`;
truncate table `apq_availability`;
truncate table `apq_equipment`;
truncate table `apq_stops`;
truncate table `apq_counts`;
truncate table `apq_setupandstart`;
truncate table `apq_prodtimes`;
truncate table `apq_availabilitysummary`;
truncate table `apq_equipmentsummary`;
truncate table `apq_stopssummary`;
truncate table `apq_countssummary`;
truncate table `apq_setupandstartsummary`;
truncate table `apq_prodtimessummary`;
truncate table `apq_availabilitybyarea`;
truncate table `apq_equipmentbyarea`;
truncate table `apq_stopsbyarea`;
truncate table `apq_countsbyarea`;
truncate table `apq_setupandstartbyarea`;
truncate table `apq_prodtimesbyarea`;
truncate table `apq_availabilitybyline`;
truncate table `apq_equipmentbyline`;
truncate table `apq_stopsbyline`;
truncate table `apq_countsbyline`;
truncate table `apq_setupandstartbyline`;
truncate table `apq_prodtimesbyline`;
truncate table `apq_stopsbyequipment`;
truncate table `apq_countsbyequipment`;
truncate table `apq_setupandstartbyequipment`;
truncate table `apq_prodtimesbyequipment`;

select
	 (select count(*) from `apq_settings`) 					as `st`
    ,(select count(*) from `apq_daysoff`)					as `do`
    ,(select count(*) from `apq_scheduletemplate`) 			as `sc`
	,(select count(*) from `apq_runtime`) 					as `rt`
	,(select count(*) from `apq_availability`) 				as `av`
	,(select count(*) from `apq_equipment`) 				as `eq`
	,(select count(*) from `apq_stops`) 					as `st`
	,(select count(*) from `apq_counts`) 					as `ct`
	,(select count(*) from `apq_setupandstart`) 			as `ss`
	,(select count(*) from `apq_prodtimes`) 				as `pt`
	,(select count(*) from `apq_availabilitysummary`) 		as `as`
	,(select count(*) from `apq_equipmentsummary`) 			as `es`
	,(select count(*) from `apq_stopssummary`) 				as `ss`
	,(select count(*) from `apq_countssummary`) 			as `cs`
	,(select count(*) from `apq_setupandstartsummary`) 		as `se`
	,(select count(*) from `apq_prodtimessummary`) 			as `ps`
	,(select count(*) from `apq_availabilitybyarea`) 		as `aa`
	,(select count(*) from `apq_equipmentbyarea`) 			as `ea`
	,(select count(*) from `apq_stopsbyarea`) 				as `sa`
	,(select count(*) from `apq_countsbyarea`) 				as `ca`
	,(select count(*) from `apq_setupandstartbyarea`) 		as `sa`
	,(select count(*) from `apq_prodtimesbyarea`) 			as `pa`
	,(select count(*) from `apq_availabilitybyline`) 		as `al`
	,(select count(*) from `apq_equipmentbyline`) 			as `el`
	,(select count(*) from `apq_stopsbyline`) 				as `sl`
	,(select count(*) from `apq_countsbyline`) 				as `cl`
	,(select count(*) from `apq_setupandstartbyline`) 		as `sl`
	,(select count(*) from `apq_prodtimesbyline`) 			as `pl`
	,(select count(*) from `apq_stopsbyequipment`) 			as `se`
	,(select count(*) from `apq_countsbyequipment`) 		as `ce`
	,(select count(*) from `apq_setupandstartbyequipment`) 	as `se`
	,(select count(*) from `apq_prodtimesbyequipment`) 		as `pe`;

-- Settings (Config)
select * from `apq_settings`;
select * from `apq_runtime`;
select * from `apq_availability`;
select * from `apq_equipment`;

-- Raw Data
select * from `apq_stops`;
select * from `apq_counts`;
select * from `apq_setupandstart`;
select * from `apq_prodtimes`;

-- Data Summary
select * from `apq_availabilitysummary`;
select * from `apq_equipmentsummary`;
select * from `apq_stopssummary`;
select * from `apq_countssummary`;
select * from `apq_setupandstartsummary`;
select * from `apq_prodtimessummary`;

-- Summary Indexes
select * from `v_apq_get_productionschedule`;
select * from `v_apq_get_stops`;
select * from `v_apq_get_counts`;
select * from `v_apq_get_availability`;
select * from `v_apq_get_index`;
select * from `v_apq_get_datachart` order by `idruntime`, `title`;

select * from `v_apq_get_index` `nd` inner join `v_apq_get_datachart` `dc` on `dc`.`idruntime` = `nd`.`idruntime`
where `nd`.`idruntime` in ( select max(`rt`.`idruntime`) from `apq_runtime` `rt` ) order by `dc`.`title`;

-- Data by area 
select * from `apq_availabilitybyarea`;
select * from `apq_equipmentbyarea`;
select * from `apq_stopsbyarea`;
select * from `apq_countsbyarea`;
select * from `apq_setupandstartbyarea`;
select * from `apq_prodtimesbyarea`;

-- Indexes by area
select * from `v_apq_get_productionschedulebyarea`;
select * from `v_apq_get_stopsbyarea`;
select * from `v_apq_get_countsbyarea`;
select * from `v_apq_get_availabilitybyarea`;
select * from `v_apq_get_indexbyarea`;
select * from `v_apq_get_datachartbyarea` order by `idruntime`, `area`, `title`;

call `spapq_rpt_apqbyarea`(-1, 0);
call `spapq_rpt_apqbyarea`(-1, 2);
call `spapq_rpt_apqbyarea`(1, 0);
call `spapq_rpt_apqbyarea`(1, 2);

-- Data By line 
select * from `apq_availabilitybyline`;
select * from `apq_equipmentbyline`;
select * from `apq_stopsbyline`;
select * from `apq_countsbyline`;
select * from `apq_setupandstartbyline`;
select * from `apq_prodtimesbyline`;

-- Indexes By line
select * from `v_apq_get_productionschedulebyline`;
select * from `v_apq_get_stopsbyline`;

select * from `v_apq_get_countsbyline`;
select * from `v_apq_get_availabilitybyline`;
select * from `v_apq_get_indexbyline`;
select * from `v_apq_get_datachartbyline`  ORDER BY `idruntime`, `area`, `line`, `title`;

call `spapq_rpt_apqbyline`( -1, 0);
call `spapq_rpt_apqbyline`( -1, 2);
call `spapq_rpt_apqbyline`(  1, 0);
call `spapq_rpt_apqbyline`(  1, 2);

-- Data By Equipment
select * from `apq_stopsbyequipment`;
select * from `apq_countsbyequipment`;
select * from `apq_setupandstartbyequipment`;
select * from `apq_prodtimesbyequipment`;

-- Indexes By Equipment
select * from `v_apq_get_productionschedulebyequipment`;
select * from `v_apq_get_stopsbyequipment`;

select * from `v_apq_get_countsbyequipment`;
select * from `v_apq_get_availabilitybyequipment`;
select * from `v_apq_get_indexbyequipment`;
select * from `v_apq_get_datachartbyequipment` order by `idruntime`, `area`, `line`, `idequipment`, `title`;

call `spapq_rpt_apqbyequipment`( -1, '');
call `spapq_rpt_apqbyequipment`( -1, 'TOYO-14 30T');
call `spapq_rpt_apqbyequipment`(  1, '');
call `spapq_rpt_apqbyequipment`(  1, 'TOYO-14 30T');

call `spapq_rpt_counts`(1);

-- ==========================================================================================================================================

select * from `apq_runtime` `rt`;
select * from `apq_stops` `st`;
select * from `apq_counts` `av`;
select * from `apq_equipment` `eq`;
select * from `apq_availability` `aa`;
select * from `apq_prodtimes` `pt`;
select * from `apq_setupandstart` `ss`;

select * from `apq_stopssummary` `st`;
select * from `apq_countssummary` `av`;
select * from `apq_equipmentsummary` `eq`;
select * from `apq_availabilitysummary` `aa`;
select * from `apq_prodtimessummary` `pt`;
select * from `apq_setupandstartsummary` `ss`;

call `spapq_rpt_apq` (0);
call `spapq_rpt_apqbyarea`(0, 0);
call `spapq_rpt_apqbyline`(1, 0, 0);
call `spapq_rpt_apqbyequipment`(1, 1, 1, '%');

call `spapq_rpt_counts`(1, 0, 0, '%');
call `spapq_rpt_equipment`(1, 0, 0, '%');
call `spapq_rpt_prodtimes`(1, 0, 0, '%');
call `spapq_rpt_setupandstarts`(1, 0, 0, '%');
call `spapq_rpt_stops`(1, 0, 0, '%');

call `spapq_execute_runtime`(1);
call `spapq_create_availability`( 1, '2017-4-1 00:00', '2017-5-1 00:00');

-- By summary
call `spapq_create_equipmentsummary`( 1 );
call `spapq_create_availabilitysummary`( 1 );
call `spapq_create_prodtimessummary`( 1 );
call `spapq_create_stopssummary`( 1 );
call `spapq_create_countssummary`( 1 );
call `spapq_create_setupandstartsummary`( 1 );

-- By area
call `spapq_create_equipmentbyarea`( 1 );
call `spapq_create_availabilitybyarea`( 1 );
call `spapq_create_prodtimesbyarea`( 1 );
call `spapq_create_stopsbyarea`( 1 );
call `spapq_create_countsbyarea`( 1 );
call `spapq_create_setupandstartbyarea`( 1 );

-- By line
call `spapq_create_equipmentbyline`( 1 );
call `spapq_create_availabilitybyline`( 1 );
call `spapq_create_prodtimesbyline`( 1 );
call `spapq_create_stopsbyline`( 1 );
call `spapq_create_countsbyline`( 1 );
call `spapq_create_setupandstartbyline`( 1 );

-- By Equipment
call `spapq_create_stopsbyequipment`( 1 );
call `spapq_create_countsbyequipment`( 1 );
call `spapq_create_prodtimesbyequipment`( 1 );
call `spapq_create_setupandstartbyequipment`( 1 );

-- ==================================================================================

select * from `v_apq_get_datachart`;
select * from `v_apq_get_fields_level3`;

select * from `apq_runtime`;
call `spapq_rpt_apq`(1);
call `spapq_rpt_apqbyarea`(1, 0);
call `spapq_rpt_apqbyline`(1, 0, 0);
call `spapq_rpt_apqbyequipment`(1, 1, 3, 'TOYO-40 180T');

select * from `apq_stops` where `idequipment` = 'TOYO-63 30T';
select * from `apq_counts` where `idequipment` = 'TOYO-40 180T';
select * from `apq_setupandstart` where `idequipment` = 'TOYO-40 180T';
select * from `apq_prodtimes` where `idequipment` = 'TOYO-40 180T';

select * from `apq_prodtimesbyequipment` where `idequipment` = 'TOYO-40 180T';
select * from `v_apq_get_productionschedulebyequipment` where `idequipment` = 'TOYO-40 180T';
select * from `v_apq_get_stopsbyequipment` where `idequipment` = 'TOYO-63 30T';
select * from `v_apq_get_availabilitybyequipment` where `idequipment` = 'TOYO-63 30T';
select * from `v_apq_get_countsbyequipment` where `idequipment` = 'TOYO-40 180T';
select * from `v_apq_get_fields_level1byequipment` where `idequipment` = 'TOYO-40 180T';
select * from `v_apq_get_fields_level2byequipment` where `idequipment` = 'TOYO-40 180T';
select * from `v_apq_get_fields_level3byequipment` where `idequipment` = 'TOYO-40 180T';

select * from `v_apq_get_availabilitybyequipment` where `idequipment` = 'TOYO-40 180T';
select * from `v_apq_get_countsbyequipment` where `idequipment` = 'TOYO-40 180T';


