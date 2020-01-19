CREATE TABLE urias_escudero.flights 
(	FlightID 				INT NOT NULL AUTO_INCREMENT,
	FlightDatetime			datetime,
    FlightDepartureCity 	varchar(50),
    FlightDestinationCity 	varchar(50),
    Ontime 					int,
  PRIMARY KEY (FlightID)
);

INSERT INTO flights (FlightDateTime, FlightDepartureCity, FlightDestinationCity, Ontime)
SELECT '2016/01/01','Dallas-Texas','L.A.',1  UNION
SELECT '2016/02/01','Austin-Texas','New York',1  UNION
SELECT '2016/03/01','Houston-Texas','New Jersy',0  UNION
SELECT '2016/04/01','San Antonio-Texas','Mesquite',1  UNION
SELECT '2016/05/01','Lewisville-Texas','Albany',0  UNION
SELECT '2016/06/01','Orlando-Florida','Atlanta',1  UNION
SELECT '2016/07/01','Chicago-Illinois','Oklahoma City',1  UNION
SELECT '2016/08/01','New Orleans-Louisiana','Memphis',0  UNION
SELECT '2016/09/01','Miami-Florida','Charlotte',1  UNION
SELECT '2016/10/01','Sacramento-California','San Francisco',1;

CREATE TABLE  urias_escudero.HospitalStaff
(	EmpID 		INT NOT NULL AUTO_INCREMENT,
	NameJob 	varchar(50) ,
	HireDate 	datetime NULL,
	Location 	varchar(150) NULL,
  PRIMARY KEY (EmpID)
);

INSERT INTO HospitalStaff (NameJob,HireDate,Location)
SELECT		'Dr. Johnson_Doctor'	,'2016/03/01',	'Dallas-Texas' UNION
SELECT		'Nurse Jackie_Nurse'	,'2016/10/15',	'Mesquite-Texas' UNION
SELECT		'Anne_Nurse Assistant'	,'2016/11/01',	'Denton-Texas' UNION
SELECT		'Dr. Jackson_Doctor'	,'2016/04/02',	'Irving-Texas' UNION
SELECT		'Jamie_Nurse'			,'2016/02/15',	'San Francisco-California' UNION
SELECT		'Aesha_Nurse Assistant'	,'2016/06/30',	'Oakland-California' UNION
SELECT		'Dr. Ali_Doctor'		,'2016/07/04',	'L.A.-California' UNION
SELECT		'Evelyn_Nurse'			,'2016/01/07',	'Fresno-California' UNION
SELECT		'James Worthy_Nurse Assistant'	,'2016/08/01',	'Orlando-Florida' UNION
SELECT		'Anand_Doctor'			,'2016/03/01',	'Miami-Florida';

SELECT 		*
FROM 		flights;

SELECT		*
FROM		HospitalStaff;

-- 2. set variable equal to number of flights that were late.
Set @TotalLateFlights = 3;
select @TotalLateFlights;

-- 3. * amount by amount lost per flight $1,029, create additional variable for that amount.
set @AmountLostPerLate = 1029;
select (@TotalLateFlights * @AmountLostPerLate) as TotalLost;
set @TotalLost = 3087;

-- 4. Take TotalLost and subtract from total profit ($45,000) and store that number in a variable.
set @TotalProfit = 45000;
select (@TotalProfit - @TotalLost) as RemainingProfit;
set @RemainingProfit = 41913;

-- 5. Find earliest FlightDate and add 10 years to it, store in variable.
set @EarliestFlightDate = '2016-01-01';
set @Length = 10;
select date_add(@EarliestFlightDate, interval @Length year);
set @FutureDate = '2026-01-01';

-- 6. Create a temp table with Departure City and State in 2 different columns along with Flight Destination, City and Ontime.
create temporary table urias_escudero.FlightsTempTable (
	DepartureCity varchar(50),
    State varchar(50),
    FlightDestinationCity varchar(50),
    Ontime int
);

select *
from FlightsTempTable;

-- 7. Create temp table storing all info of flights that were on time.
create temporary table urias_escudero.FlightsOnTimeTable
(	FlightID 				INT NOT NULL AUTO_INCREMENT,
	FlightDatetime			datetime,
    FlightDepartureCity 	varchar(50),
    FlightDestinationCity 	varchar(50),
    Ontime 					int,
  PRIMARY KEY (FlightID)
);

insert into FlightsOnTimeTable (FlightDateTime, FlightDepartureCity, FlightDestinationCity, Ontime)
SELECT '2016/01/01','Dallas-Texas','L.A.',1  UNION
SELECT '2016/02/01','Austin-Texas','New York',1  UNION
SELECT '2016/04/01','San Antonio-Texas','Mesquite',1  UNION
SELECT '2016/06/01','Orlando-Florida','Atlanta',1  UNION
SELECT '2016/07/01','Chicago-Illinois','Oklahoma City',1  UNION
SELECT '2016/09/01','Miami-Florida','Charlotte',1  UNION
SELECT '2016/10/01','Sacramento-California','San Francisco',1;

select *
from FlightsOnTimeTable;

-- 8. Create Temp Tabl storing info of non-Texas flights.

create temporary table urias_escudero.NonTexasFlightsTable
(	FlightID 				INT NOT NULL AUTO_INCREMENT,
	FlightDatetime			datetime,
    FlightDepartureCity 	varchar(50),
    FlightDestinationCity 	varchar(50),
    Ontime 					int,
  PRIMARY KEY (FlightID)
);

insert into NonTexasFlightsTable (FlightDateTime, FlightDepartureCity, FlightDestinationCity, Ontime)
SELECT '2016/06/01','Orlando-Florida','Atlanta',1  UNION
SELECT '2016/07/01','Chicago-Illinois','Oklahoma City',1  UNION
SELECT '2016/08/01','New Orleans-Louisiana','Memphis',0  UNION
SELECT '2016/09/01','Miami-Florida','Charlotte',1  UNION
SELECT '2016/10/01','Sacramento-California','San Francisco',1;

select *
from NonTexasFlightsTable;

-- 9. Create variable to store number of all employees from Texas.
SELECT		Locate('Texas', Location) and Locate('Nurse', NameJob)
from	HospitalStaff;

set @TexasEmployees = 2;

-- 10. Create variable to store number of all doctors from Texas.
select Locate('Texas', Location) and Locate('Doctor', NameJob)
from HospitalStaff;

set @TexasDoctors = 2;

-- 11. Create temp table using data in HospitalStaffTable with columns: Name, Job, HireDate, City, State.
create temporary table urias_escudero.TempHospitalStaffTable
(	Name	varchar(50) ,
    Job 	varchar(50) ,
	HireDate 	datetime NULL,
	City 	varchar(50) NULL,
    State	varchar(50) NULL
);

insert into TempHospitalStaffTable (Name, Job, HireDate, City, State)
SELECT		'Dr. Johnson', 'Doctor'	,'2016/03/01',	'Dallas', 'Texas' UNION
SELECT		'Nurse Jackie', 'Nurse'	,'2016/10/15',	'Mesquite', 'Texas' UNION
SELECT		'Anne', 'Nurse Assistant'	,'2016/11/01',	'Denton', 'Texas' UNION
SELECT		'Dr. Jackson', 'Doctor'	,'2016/04/02',	'Irving','Texas' UNION
SELECT		'Jamie', 'Nurse'			,'2016/02/15',	'San Francisco', 'California' UNION
SELECT		'Aesha', 'Nurse Assistant'	,'2016/06/30',	'Oakland', 'California' UNION
SELECT		'Dr. Ali', 'Doctor'		,'2016/07/04',	'L.A.', 'California' UNION
SELECT		'Evelyn', 'Nurse'			,'2016/01/07',	'Fresno', 'California' UNION
SELECT		'James Worthy', 'Nurse Assistant'	,'2016/08/01',	'Orlando', 'Florida' UNION
SELECT		'Anand', 'Doctor'			,'2016/03/01',	'Miami', 'Florida';

select *
from TempHospitalStaffTable;

-- 12. Create a temp table using data from HospitalTable with following columns: NameJob, DateYear, DateMonth, DateDay.
create temporary table urias_escudero.TempHospitalTable2
(	NameJob varchar(50),
	DateYear int,
    DateMonth Varchar(50),
    DateDay int
);

insert into TempHospitalTable2 (NameJob, DateYear, DateMonth, DateDay)
select		'Dr. Johnson_Doctor'	, 2016, 'March', 1  UNION
SELECT		'Nurse Jackie_Nurse'	, 2016, 'October', 15 UNION
SELECT		'Anne_Nurse Assistant'	, 2016, 'November', 1 UNION
SELECT		'Dr. Jackson_Doctor'	, 2016, 'April', 2 UNION
SELECT		'Jamie_Nurse'			, 2016, 'February', 15 UNION
SELECT		'Aesha_Nurse Assistant'	, 2016, 'June', 30 UNION
SELECT		'Dr. Ali_Doctor'		, 2016, 'July', 4 UNION
SELECT		'Evelyn_Nurse'			, 2016, 'January', 7 UNION
SELECT		'James Worthy_Nurse Assistant'	, 2016, 'August', 1 UNION
SELECT		'Anand_Doctor'			, 2016, 'March', 1;

select *
from TempHospitalTable2;

