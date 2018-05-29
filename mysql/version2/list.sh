mysql -u developer -pTest.01 reports < spapq_create_equipmentsummary.sql
mysql -u developer -pTest.01 reports < spapq_create_equipmentbyarea.sql
mysql -u developer -pTest.01 reports < spapq_create_equipmentbyline.sql

mysql -u developer -pTest.01 reports < spapq_create_stopssummary.sql
mysql -u developer -pTest.01 reports < spapq_create_stopsbyarea.sql
mysql -u developer -pTest.01 reports < spapq_create_stopsbyline.sql
mysql -u developer -pTest.01 reports < spapq_create_stopsbyequipment.sql

mysql -u developer -pTest.01 reports < spapq_create_setupandstartsummary.sql
mysql -u developer -pTest.01 reports < spapq_create_setupandstartbyarea.sql
mysql -u developer -pTest.01 reports < spapq_create_setupandstartbyline.sql
mysql -u developer -pTest.01 reports < spapq_create_setupandstartbyequipment.sql

mysql -u developer -pTest.01 reports < spapq_create_availabilitysummary.sql
mysql -u developer -pTest.01 reports < spapq_create_availability.sql
mysql -u developer -pTest.01 reports < spapq_create_availabilitybyarea.sql
mysql -u developer -pTest.01 reports < spapq_create_availabilitybyline.sql

mysql -u developer -pTest.01 reports < spapq_create_countssummary.sql
mysql -u developer -pTest.01 reports < spapq_create_countsbyarea.sql
mysql -u developer -pTest.01 reports < spapq_create_countsbyline.sql
mysql -u developer -pTest.01 reports < spapq_create_countsbyequipment.sql

mysql -u developer -pTest.01 reports < spapq_create_prodtimessummary.sql
mysql -u developer -pTest.01 reports < spapq_create_prodtimesbyarea.sql
mysql -u developer -pTest.01 reports < spapq_create_prodtimesbyline.sql
mysql -u developer -pTest.01 reports < spapq_create_prodtimesbyequipment.sql

mysql -u developer -pTest.01 reports < spapq_execute_runtime.sql

mysql -u developer -pTest.01 reports < spapq_rpt_equipment.sql
mysql -u developer -pTest.01 reports < spapq_rpt_stops.sql
mysql -u developer -pTest.01 reports < spapq_rpt_setupandstarts.sql
mysql -u developer -pTest.01 reports < spapq_rpt_availability.sql
mysql -u developer -pTest.01 reports < spapq_rpt_counts.sql
mysql -u developer -pTest.01 reports < spapq_rpt_prodtimes.sql

mysql -u developer -pTest.01 reports < v_apq_get_stops.sql
mysql -u developer -pTest.01 reports < v_apq_get_stopsbyarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_stopsbyline.sql
mysql -u developer -pTest.01 reports < v_apq_get_stopsbyequipment.sql

mysql -u developer -pTest.01 reports < v_apq_get_productionschedule.sql
mysql -u developer -pTest.01 reports < v_apq_get_productionschedulebyarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_productionschedulebyline.sql
mysql -u developer -pTest.01 reports < v_apq_get_productionschedulebyequipment.sql

mysql -u developer -pTest.01 reports < v_apq_get_availability.sql
mysql -u developer -pTest.01 reports < v_apq_get_availabilitybyarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_availabilitybyline.sql
mysql -u developer -pTest.01 reports < v_apq_get_availabilitybyequipment.sql

mysql -u developer -pTest.01 reports < v_apq_get_counts.sql
mysql -u developer -pTest.01 reports < v_apq_get_countsbyarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_countsbyline.sql
mysql -u developer -pTest.01 reports < v_apq_get_countsbyequipment.sql

mysql -u developer -pTest.01 reports < v_apq_get_fields_level1.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level1byarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level1byline.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level1byequipment.sql

mysql -u developer -pTest.01 reports < v_apq_get_fields_level2.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level2byarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level2byline.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level2byequipment.sql

mysql -u developer -pTest.01 reports < v_apq_get_fields_level3.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level3byarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level3byline.sql
mysql -u developer -pTest.01 reports < v_apq_get_fields_level3byequipment.sql

mysql -u developer -pTest.01 reports < v_apq_get_datachart.sql
mysql -u developer -pTest.01 reports < v_apq_get_datachartbyarea.sql
mysql -u developer -pTest.01 reports < v_apq_get_datachartbyline.sql
mysql -u developer -pTest.01 reports < v_apq_get_datachartbyequipment.sql

mysql -u developer -pTest.01 reports < spapq_rpt_apq.sql
mysql -u developer -pTest.01 reports < spapq_rpt_apqbyarea.sql
mysql -u developer -pTest.01 reports < spapq_rpt_apqbyline.sql
mysql -u developer -pTest.01 reports < spapq_rpt_apqbyequipment.sql
