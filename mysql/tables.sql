drop table if exists `apq_settings`;
create table `apq_settings` (
	`period`	int
);

insert into `apq_settings` (`period` ) values (30);

drop table if exists `apq_daysoff`;
create table `apq_daysoff` (
	    `date`			datetime
	  , `description`	varchar(100)
);

insert into `apq_daysoff` ()
	  values('2018-1-1', 'Plant shutdown')
	, ('2018-1-2', 'Plant shutdown')
	, ('2018-2-5', 'Constitution Day')
	, ('2018-3-31', 'Holy Saturday')
	, ('2018-4-30', 'Labor Day');

drop table if exists `apq_scheduletemplate`;
create table `apq_scheduletemplate` (
	  `dayofweek`	int
	, `working`		float
	, `break`		float
	, `off`			float
);

insert into `apq_scheduletemplate` (`dayofweek`, `working`, `break`, `off`) 
	  values ( 1, 0, 0, 24)
	, ( 2, 23, 1, 0)
	, ( 3, 23, 1, 0)
	, ( 4, 23, 1, 0)
	, ( 5, 23, 1, 0)
	, ( 6, 23, 1, 0)
	, ( 8, 14, 0, 10);

drop table if exists `apq_runtime`;
create table `apq_runtime` (
	    `idruntime`	bigint auto_increment primary key
	  , `from`		datetime
	  , `to`		datetime
	  , `period`	int
);

drop table if exists `apq_availability`;
create table `apq_availability` (
	  `idruntime`	bigint
	, `date`		datetime
	, `dayofweek`	int
	, `working`		float
	, `break`		float
	, `off`			float
);

-- Raw data
drop table if exists `apq_equipment`;
create table `apq_equipment` (
	  `idruntime`	bigint
	, `idequipment`	varchar(20)
	, `power`		int
	, `area`		int
	, `line`		int
);

drop table if exists `apq_stops`;
create table `apq_stops` (
	  `idruntime`		bigint
	, `idequipment`		varchar(20)
	, `date`			datetime
	, `idparo`			varchar(10)
	, `tipoparo`		varchar(100)
	, `clasification`	varchar(50)
	, `time`			float
);

drop table if exists `apq_prodtimes`;
create table `apq_prodtimes` (
	  `idruntime`		bigint
	, `workorder`		varchar(20)
	, `idequipment`		varchar(20)
	, `starttime`		datetime
	, `endtime`			datetime
	, `time`			float
);

drop table if exists `apq_counts`;
create table `apq_counts` (
	  `idruntime`		bigint
	, `itemid`			varchar(35)
	, `idequipment`		varchar(20)
	, `date`			datetime
	, `cycletime`		float
	, `goodcount`		float
	, `badcount`		float
	, `totalcount`		float
	, `goodtime`		float
	, `losstime`		float
	, `totaltime`		float
);

drop table if exists `apq_setupandstart`;
create table `apq_setupandstart` (
	  `idruntime`		bigint
	, `workorder`		varchar(35)
	, `idequipment`		varchar(20)
	, `date`			datetime
	, `idusm`			varchar(15)
	, `actsetuptime`	float
	, `actstarttime`	float
	, `stdsetuptime`	float
	, `stdstarttime`	float
);

-- Summary
drop table if exists `apq_availabilitysummary`;
create table `apq_availabilitysummary` (
	  `idruntime`				bigint
	, `plannedproductiontime`	float
	, `plannedstop`				float
	, `scheduleLoss`			float
);

drop table if exists `apq_equipmentsummary`;
create table `apq_equipmentsummary` (
	  `idruntime`	bigint
	, `power`		float
	, `total`		float
);

drop table if exists `apq_prodtimessummary`;
create table `apq_prodtimessummary` (
	  `idruntime`		bigint
	, `time`			float
);

drop table if exists `apq_stopssummary`;
create table `apq_stopssummary` (
	  `idruntime`		bigint
	, `clasification`	varchar(50)
	, `time`			float
);

drop table if exists `apq_countssummary`;
create table `apq_countssummary` (
	  `idruntime`		bigint
	, `goodcount`		float
	, `badcount`		float
	, `totalcount`		float
	, `goodtime`			float
	, `losstime`		float
	, `totaltime`		float
);

drop table if exists `apq_setupandstartsummary`;
create table `apq_setupandstartsummary` (
	  `idruntime`		bigint
	, `actsetuptime`	float
	, `actstarttime`	float
	, `stdsetuptime`	float
	, `stdstarttime`	float
);

-- BY AREA
drop table if exists `apq_availabilitybyarea`;
create table `apq_availabilitybyarea` (
	  `idruntime`				bigint
	, `area`					int
	, `numequipments`			float
	, `plannedproductiontime`	float
	, `plannedstop`				float
	, `scheduleloss`			float
);

drop table if exists `apq_equipmentbyarea`;
create table `apq_equipmentbyarea` (
	  `idruntime`	bigint
	, `area`		int
	, `power`		float
	, `total`		float
);

drop table if exists `apq_prodtimesbyarea`;
create table `apq_prodtimesbyarea` (
	  `idruntime`		bigint
	, `area`			int
	, `time`			float
);


drop table if exists `apq_stopsbyarea`;
create table `apq_stopsbyarea` (
	  `idruntime`		bigint
	, `area`			int
	, `clasification`	varchar(50)
	, `time`			float
);

drop table if exists `apq_countsbyarea`;
create table `apq_countsbyarea` (
	  `idruntime`		bigint
	, `area`			int
	, `goodcount`		float
	, `badcount`		float
	, `totalcount`		float
	, `goodtime`			float
	, `losstime`		float
	, `totaltime`		float
);

drop table if exists `apq_setupandstartbyarea`;
create table `apq_setupandstartbyarea` (
	  `idruntime`		bigint
	, `area`			int
	, `actsetuptime`	float
	, `actstarttime`	float
	, `stdsetuptime`	float
	, `stdstarttime`	float
);

-- BY LINE
drop table if exists `apq_availabilitybyline`;
create table `apq_availabilitybyline` (
	  `idruntime`				bigint
	, `area`					int
	, `line`					int
	, `numEquipments`			int
	, `plannedproductiontime`	float
	, `plannedstop`				float
	, `scheduleLoss`			float
);

drop table if exists `apq_equipmentbyline`;
create table `apq_equipmentbyline` (
	  `idruntime`	bigint
	, `area`		int
	, `line`		int
	, `power`		float
	, `total`		float
);

drop table if exists `apq_prodtimesbyline`;
create table `apq_prodtimesbyline` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `time`			float
);


drop table if exists `apq_stopsbyline`;
create table `apq_stopsbyline` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `clasification`	varchar(50)
	, `time`			float
);

drop table if exists `apq_countsbyline`;
create table `apq_countsbyline` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `goodcount`		float
	, `badcount`		float
	, `totalcount`		float
	, `goodtime`		float
	, `losstime`		float
	, `totaltime`		float
);

drop table if exists `apq_setupandstartbyline`;
create table `apq_setupandstartbyline` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `actsetuptime`	float
	, `actstarttime`	float
	, `stdsetuptime`	float
	, `stdstarttime`	float
);

-- BY EQUIPMENT
drop table if exists `apq_availabilitybyequipment`;
create table `apq_availabilitybyequipment` (
	  `idruntime`				bigint
	, `idequipment`				varchar(20)
	, `plannedproductiontime`	float
	, `schedulesoss`			float
	, `plannedstop`				float
)
;

drop table if exists `apq_prodtimesbyequipment`;
create table `apq_prodtimesbyequipment` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `idequipment`		varchar(20)
	, `time`			float
)
;

drop table if exists `apq_stopsbyequipment`;
create table `apq_stopsbyequipment` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `idequipment`		varchar(20)
	, `clasification`	varchar(50)
	, `time`			float
);

drop table if exists `apq_countsbyequipment`;
create table `apq_countsbyequipment` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `idequipment`		varchar(20)
	, `goodcount`		float
	, `badcount`		float
	, `totalcount`		float
	, `goodtime`		float
	, `losstime`		float
	, `totaltime`		float
);


drop table if exists `apq_setupandstartbyequipment`;
create table `apq_setupandstartbyequipment` (
	  `idruntime`		bigint
	, `area`			int
	, `line`			int
	, `idequipment`		varchar(20)
	, `actsetuptime`	float
	, `actstarttime`	float
	, `stdsetuptime`	float
	, `stdstarttime`	float
);
