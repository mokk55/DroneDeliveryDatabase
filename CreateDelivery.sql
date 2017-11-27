USE delivery;

DROP TABLE Status;
DROP TABLE DroneStatus;
DROP TABLE Orders;
DROP TABLE RoutePosition;
DROP TABLE Routes;
DROP TABLE Drones;

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
    PositionNum int,
    x int NOT NULL,
    y int NOT NULL,
    z int NOT NULL,
    PRIMARY KEY (RoutesKey, PositionNum),
	FOREIGN KEY (RoutesKey) REFERENCES Routes(RouteID)
);

CREATE TABLE Drones (
    DroneID int NOT NULL auto_increment,
    OrderID int NOT NULL,
    RoutesKey int NOT NULL,
    DroneStatusKey int NOT NULL,
    PRIMARY KEY (DroneID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (RoutesKey) REFERENCES RoutePosition(RoutesKey),
    FOREIGN KEY (DroneStatusKey) REFERENCES DroneStatus(DroneStatusID)
);


INSERT INTO status(StatusDesc) values('Initial');
INSERT INTO status(StatusDesc) values('Route Ready');
INSERT INTO status(StatusDesc) values('En Route');
INSERT INTO status(StatusDesc) values('Complete');
INSERT INTO status(StatusDesc) values('Failed');
INSERT INTO status(StatusDesc) values('Archived');

INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('2', '2', '2', '35.3', '63.12', '2.69', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('2', '2', '2', '34', '125', '25', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('2', '2', '2', '24', '61', '52', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('2', '2', '2', '2.52', '3.246', '3', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('2', '2', '2', '2.35', '8', '2.63', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('2', '2', '2', '0.34', '243', '6.356', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('10.5', '10.5', '10.5', '29.63', '2.346', '34', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('10.5', '10.5', '10.5', '3.62', '34.23', '68', '2');
INSERT INTO `delivery`.`orders` (`SrcX`, `SrcY`, `SrcZ`, `DestX`, `DestY`, `DestZ`, `StatusKey`) VALUES ('10.5', '10.5', '10.5', '93.2', '6', '90', '2');
