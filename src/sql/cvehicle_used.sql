CREATE TABLE VEHICLE_USED (
    FIRST_USE_DATE DATE,
    LAST_USE_DATE DATE NOT NULL,
    ODOMETER_START NUMBER(8) NOT NULL,
    ODOMETER_FINISH NUMBER(8) NOT NULL,
    VEHICLE_REGISTER_NUM NUMBER(5) NOT NULL,
    DRIVER_DNI NUMBER(8),
    CONSTRAINT PK_VEHICLE_USED PRIMARY KEY (FIRST_USE_DATE),
    CONSTRAINT FK_VEHICLEUSED_VEHICLE FOREIGN KEY(VEHICLE_REGISTER_NUM) REFERENCES VEHICLE (VEHICLE_REGISTER_NUM),
    CONSTRAINT FK_VEHICLEUSED_DIVER FOREIGN KEY(DRIVER_DNI) REFERENCES DRIVER (DNI)
);