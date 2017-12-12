DROP DATABASE delivery;

CREATE DATABASE delivery;

USE delivery;

CREATE TABLE Status (
    StatusID int NOT NULL auto_increment,
    StatusDesc VARCHAR(256),
    PRIMARY KEY (StatusID)
);

CREATE TABLE DroneStatus (
    DroneStatusID int NOT NULL auto_increment,
    StatusDesc VARCHAR(256),
    PRIMARY KEY (DroneStatusID)
);

CREATE TABLE Orders (
    OrderID int NOT NULL auto_increment,
    SrcX float NOT NULL,
    SrcY float NOT NULL,
    SrcZ float NOT NULL,
    
    DestX float NOT NULL,
    DestY float NOT NULL,
    DestZ float NOT NULL,
    
    StatusKey int NOT NULL,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (StatusKey) REFERENCES Status(StatusID)
);

CREATE TABLE Routes (
    RouteID int NOT NULL auto_increment,
    OrderKey int NOT NULL,
    PRIMARY KEY (RouteID),
    FOREIGN KEY (OrderKey) REFERENCES Orders(OrderID)
);

CREATE TABLE RoutePosition (
    RoutesKey int NOT NULL,
    PositionNum int NOT NULL,
    x int NOT NULL,
    y int NOT NULL,
    z int NOT NULL,
    PRIMARY KEY (RoutesKey, PositionNum),
	FOREIGN KEY (RoutesKey) REFERENCES Routes(RouteID)
);

CREATE TABLE Drones (
    DroneID int NOT NULL auto_increment,
    OrderKey int,
    RoutesKey int,
    DroneStatusKey int NOT NULL,
    PRIMARY KEY (DroneID),
    FOREIGN KEY (OrderKey) REFERENCES Orders(OrderID),
    FOREIGN KEY (RoutesKey) REFERENCES RoutePosition(RoutesKey),
    FOREIGN KEY (DroneStatusKey) REFERENCES DroneStatus(DroneStatusID),
    Index(DroneStatusKey)
);

CREATE TABLE DroneDirtyBit (
	ID int NOT NULL auto_increment,
    DroneKey int NOT NULL,
    DirtyBit int NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (DroneKey) REFERENCES Drones(DroneID),
    Index(DirtyBit)
);

delimiter //
CREATE TRIGGER bitCheck BEFORE insert ON DroneDirtyBit
FOR EACH ROW
BEGIN
	IF NEW.DirtyBit < 0 THEN
		SET DirtyBit = 0;
	ELSEIF NEW.DirtyBit > 1 THEN
		SET DirtyBit = 1;
	END IF;
END;

CREATE TRIGGER bitCheck BEFORE update ON DroneDirtyBit
FOR EACH ROW
BEGIN
	IF NEW.DirtyBit < 0 THEN
		SET DirtyBit = 0;
	ELSEIF NEW.DirtyBit > 1 THEN
		SET DirtyBit = 1;
	END IF;
END;
delimiter ;

INSERT INTO status(StatusDesc) values('Initial');
INSERT INTO status(StatusDesc) values('Route Ready');
INSERT INTO status(StatusDesc) values('Loading');
INSERT INTO status(StatusDesc) values('En Route');
INSERT INTO status(StatusDesc) values('Complete');
INSERT INTO status(StatusDesc) values('Failed');
INSERT INTO status(StatusDesc) values('Archived');

INSERT INTO DroneStatus(StatusDesc) values('Charging');
INSERT INTO DroneStatus(StatusDesc) values('Waiting');
INSERT INTO DroneStatus(StatusDesc) values('Loading');
INSERT INTO DroneStatus(StatusDesc) values('En Route');
INSERT INTO DroneStatus(StatusDesc) values('Delivering');
INSERT INTO DroneStatus(StatusDesc) values('Returning');
INSERT INTO DroneStatus(StatusDesc) values('Crashed');
