--funkcje.sql
------------------------------------------------------
create OR REPLACE function total (club varchar2) 
return int 
is 
    total_points int := 0;
begin
select sum(points)
into total_points 
from (
select host_team,guest_team,goals_host,goals_guest, CASE
	WHEN goals_host > goals_guest THEN 3
	WHEN goals_host = goals_guest THEN 1
	ELSE 0
	END as points
from matches
where host_team=club
UNION ALL
select host_team,guest_team,goals_host,goals_guest, CASE
	WHEN goals_host < goals_guest THEN 3
	WHEN goals_host = goals_guest THEN 1
	ELSE 0
	END as points
from matches
where guest_team=club
);
return total_points;
end;

-------------------------------------------------------
create or replace function goals_lost (club varchar2) 
return int
is
goals_lost int:=0;
begin
select sum(goals)
into goals_lost
from (
select host_team,guest_team,goals_host as goals 
from matches where guest_team=club 
union all 
select guest_team,host_team,goals_guest 
from matches where host_team=club);
return goals_lost;
end;
-------------------------------------------------------
create or replace function goals_hit (club varchar2) 
return int 
is
goals_hit int:=0;
begin
select sum(goals) 
into goals_hit
from (
select host_team,guest_team,goals_host as goals 
from matches 
where host_team=club 
union all 
select guest_team,host_team,goals_guest 
from matches 
where guest_team=club);
return goals_hit;
end;
---------------------------------------------------------
select distinct host_team as nazwa, total(host_team) as punkty,
goals_hit(host_team) as gole_strzelone,
goals_lost(host_team) as gole_stracone
from matches