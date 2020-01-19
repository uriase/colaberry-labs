CREATE TABLE urias_escudero.bball_stats 
(	PlayerID 		INT,
	PlayerName		Varchar(50),
    PlayerNum		INT,
    PlayerPosition	Varchar(50),
    Assist			INT,
    Rebounds		INT,
    GamesPlayed		INT,
    Points			INT,
    PlayersCoach	varchar(50)
);


INSERT INTO urias_escudero.bball_stats (PLAYERID, PLAYERNAME,PLAYERNUM,PLAYERPOSITION,ASSIST,REBOUNDS,GAMESPLAYED,POINTS,PLAYERSCOACH)
SELECT 1,'ali',20,'guard',125,80,10,60,'thompson' union
SELECT 2,'james',22,'forward',65,100,10,65,'garret' union
SELECT 3,'ralph',24, 'center',30 ,120,9,70,'samson' union
SELECT 4,'terry',30,'guard',145,90,9,75,'garret' union
SELECT 5,'dirk',32,'forward',70,110,10,80,'thompson'union
SELECT 6,'alex',34,'center',35 ,130,10,90,'garret' union
SELECT 7,'nina',40,'guard',155 ,100,9,100 ,' samson'union
SELECT 8,'krystal',42,'forward',75,100,9,95,'thompson' union
SELECT 9,'bud',44, 'center',40,125,10,90,'thompson' union
SELECT 10,'tiger',50, 'guard',160,90,10,85,'samson' union
SELECT 11,'troy',52, 'forward',80,125,10,80,'samson' union
SELECT 12,'anand',54, 'center',50,145,10,110,'samson' union
SELECT 13,'kishan',60, 'guard',120,150,9,115,'samson' union
SELECT 14,'spock',62, 'forward',85,105,8,120,'thompson' union
SELECT 15,'cory',64, 'center',55,175,10,135,'samson'

select *
from bball_stats;

-- a. Find the Number of Players at each position
select PlayerPosition, 
count(PlayerPosition)
FROM bball_stats
group by PlayerPosition

-- b. Find the Number of Players assigned to each Coach
select PlayersCoach,
count(PlayerID)
from bball_stats
group by PlayersCoach

-- c. Find the Most Points scored per game by position
select PlayerPosition, 
max(points)
from bball_stats
group by PlayerPosition

-- d. Find the Total Number of Rebounds per game by Coach.
select playerscoach, 
sum(Rebounds)
from bball_stats
group by PlayersCoach

-- e. Find the Average number of Assist by Coach.
select playerscoach,
avg(assist)
from bball_stats
group by playerscoach

-- f. Find the Average number of assist per game by Position.
select playerposition,
avg(assist)
from bball_stats
group by PlayerPosition

-- g. Find the Total number of Points by each Player Position.
select playerposition, 
sum(points)
from bball_stats
group by PlayerPosition