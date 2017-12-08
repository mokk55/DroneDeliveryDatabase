show tables;

SELECT * FROM status;
SELECT * FROM orders;
SELECT * FROM Orders o, Status s WHERE o.StatusKey = s.StatusID;
SELECT * FROM Orders o, Status s WHERE o.StatusKey = s.StatusID AND s.StatusDesc = 'Initial';

SELECT * FROM routes;
SELECT * FROM routeposition;

SELECT * FROM Routes r, RoutePosition rp WHERE rp.RoutesKey = r.RouteID;

SELECT * FROM Drones d,DroneStatus ds WHERE DroneStatusID = DroneStatusKey AND DroneID = 1;

SELECT * FROM Drones;

INSERT INTO Drones (DroneStatusKey) VALUES(1);


