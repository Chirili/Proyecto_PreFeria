CREATE TABLE PLACES (
    REGION VARCHAR(20),
    COUNTRY VARCHAR2(20) NOT NULL,
    ENTRY_DATE DATE,
    EXIT_DATE DATE,
    ODOMETER_VALUE NUMBER(7) NOT NULL,
    CONSTRAINT PK_PLACES PRIMARY KEY(REGION)
);