CREATE TABLE CARD (
    CARD_ID NUMBER(8),
    EXPIRATION_DATE DATE,
    ACQUISITION_DATE DATE,
    DRIVER_DNI NUMBER(8),
    CONSTRAINT PK_CARD PRIMARY KEY(CARD_ID),
    CONSTRAINT FK_CARD_DRIVER FOREIGN KEY(DRIVER_DNI) REFERENCES DRIVER (DNI)
);
