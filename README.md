# Proyecto Pre-Feria

## Indice

1. [Idea principal](#Idea-Principal)
2. [¿Que es un tacografo digital?](#Y-que-es-un-tacógrafo-digital)
3. [Funcionamiento del tacógrafo digital](#Funcionamiento-del-tacógrafo-digital)
4. [Datos que recoge el tacógrafo digital](#Datos-que-recoge-el-tacógrafo-digital)
5. [Modelo entidad relacion](#Modelo-entidad-relacion)
6. [Modelo relacional](#Modelo-relacional)
7. [Descrición del problema](#Descripción-del-problema)
8. [Creación de las tablas](#Creación-de-las-tablas)
9. [Restricciones a las tablas](#Restricciones-a-las-tablas)
10. [Insert a las tablas](#Insert-a-las-tabla)
11. [Updates](#Updates)
12. [Deletes](#Deletes)
13. [Consultas y subconsultas](#Consultas-y-subconsultas)
14. [Vistas](#Vistas)
15. [¿Creación de las tablas en MongoDB?](#Creacion-de-las-tablas-en-MONGODB)
### Idea Principal
La idea principal sobre el proyecto de pre-feria es hacer la estructura de una base de datos de un tacógrafo digital.

### Y que es un tacógrafo digital
Un tacógrafo digital es un aparato electrónico que se encarga de registrar eventos en la conducción de vehiculos, su precursor fué el tacógrafo analógico, el cuál esta previsto que desaparezca completamente por el digital.

### Funcionamiento del tacógrafo digital
El tacógrafo digital obtiene datos relativos a los tiempos de conducción y descansos del conductor. Esta información es la más importante de todas y constituye el sentido fundamental del tacógrafo.

### Datos que recoge el tacógrafo digital
Los eventos recogidos por el tacógrafo incluyen:
- Conducción, descanso, otros trabajos.
- Excesos de velocidad.
- Errores en el sistema.
- Conducción sin tarjeta.
- Transferencias de datos: estos datos son almacenados tanto en la memoria del tacógrafo como en la de la tarjeta.

### Modelo Entidad-Relacion

![Modelo entidad relacion](https://github.com/Chirili/Proyecto_PreFeria/blob/master/src/images/modelo_entidad_relacion.jpg)

### Modelo relacional

![Modelo relacional del proyecto](https://github.com/Chirili/Proyecto_PreFeria/blob/master/src/images/modelo_relacional.jpg)

### Descripción del problema

Se necesita almacenar en la base de datos, los datos relacionados con un tacógrafo digital:

- Se almacenará los datos de la compañia, el conductor, el vehiculo y el vehiculo usado, actividad, lugares y tarjeta.

    - De la compañía se almacenará **(el codigo, nombre de la compañia y el codigo postal).**

        > Hay que tener en cuenta que una compañia puede tener muchos conductores y un conductor puede trabajar con distintas compañias pero nunca con dos a la vez.

    - Del conductor interesa saber su **(DNI, nombre, primer y segundo apellido, el idioma preferido y la fecha de alta en la empresa).**

    - De la actividad se almacenará  **(el ID, el estado, el régimen, conducto y el tiempo).**
    
        > Teniendo en cuenta que la actividad la realiza un conductor cada ID de actividad tiene que tener asociado un DNI de un conductor que esta realizando esa actividad asi como el codigo de compañia a la que pertenece dicho conductor en ese determinado momento

    - Del vehiculo interesa saber **(el número de registro y la nación de registro de dicho vehiculo, asi como el código de la compañía a la que pertenece).**

        > Un vehiculo solo puede pertener a una empresa y una empresa puede tener tantos vehiculo como quiera.

    - Del vehiculo usado necesitamos **(el numero de registro del vehiculo, el dni del conductor que lo ha usado, el comienzo y fin del cuenta kilometros y el primer y último uso de dicho vehiculo).**

        > El dni del conductor en este punto es fundamental para saber que conductor ha usado que vehiculo y en que momento asi como la cantidad de kilometros con el cuenta kilometros.

    - De los lugares interesa saber **(La fecha de entrada y salida de dicho lugar, el país, la región, y el valor del cuenta kilometros tanto cuando entra como cuando sale).**

        > Los lugares tendran como clave el nombre de la región para saber así junto con los vehiculos usado cuando se entró a ese lugar, cuando se salió y los valores del cuenta kilometros

    - La tarjeta tiene que tener **(Un ID de tarjeta, la fecha de expiración y la fecha de adquisición de la misma y por último el DNI del conductor que la está usando ).**
        > Hay que tener en cuenta que un conductor solo debe tener una tarjeta operativa al mismo tiempo, es decir, que si tiene mas de una tarjeta es porque las demás estan caducadas.

> NOTAS:
 >> Otro dato importante a saber para terminar de comprender las tablas es que todo tiene que estar relacionado entre sí ya que el conductor trabaja entre una serie de fechas mientras, en las cuales este conductor tiene que tener una tarjeta valida vigente para poder trabajar y usarla para recoger toda la actividad que este realize, aparte de eso en ese periodo de fechas, el conductor puede visitar X lugares los cuales tambien se tienen que registrar en la tabla junto al valor del cuantakilometros que tiene que ser acorde con el rango del cuenta kilometros especificado en la tabla del vehiculo usado y el periodo de salida estar a NULL ya que un conductor puede salir de un lugar pero despues tiene que volver así que si se quiere recoger esa vuelta no tiene sentido ponerle una fecha de salida al mismo lugar.

 >> La actividad necesita de cientos de registros para poder comprenderla ya que cada dia que el conductor trabaja cada vez que este inserte los datos al tacógrafo sobre que está haciendo tienen que estar recogidos, por ejemplo el conductor X con DNI X estuvo de 6:00 a 6:15 de descanso y de 6:17 a 8:00 conduciendo y así una lista de estos registros. Ni que decir tiene que estos datos siempre tienen que estar siendo insertados con la tarjeta.

### Creación de las tablas

<details>
    <summary>Clica aquí para ver la creación de las tablas</summary>

```sql
/*
Drop table de las tablas ordenados correctamente para su funcionamiento
*/
DROP TABLE ACTIVITY;
DROP TABLE CARD;
DROP TABLE VEHICLE_USED;
DROP TABLE VEHICLE;
DROP TABLE DRIVER_WORK;
DROP TABLE PLACES_VISITED;
DROP TABLE DRIVER;
DROP TABLE PLACES;
DROP TABLE COMPANY;

/*
        ***************************
        *Creacion de la de COMPANY*
        ***************************
Esta primera tabla y la cabeza del trabajo es la recoge la informacion de la compañia en la que trabajan los conductores
*/
CREATE TABLE COMPANY (
    COD_COMPANY NUMBER(4),
    COMPANY_NAME VARCHAR2(20) NOT NULL,
    CP NUMBER(5) NOT NULL,
    CONSTRAINT PK_COMPANY PRIMARY KEY(COD_COMPANY)
);
/*
        *****************************
        *Creacion de la tabla PLACES*
        *****************************
En esta tabla se recogen los lugares a los que viaja el conductor.
*/

CREATE TABLE PLACES (
    PLACE_ID NUMBER(10),
    REGION VARCHAR(20),
    COUNTRY VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_PLACES PRIMARY KEY(PLACE_ID)
);
/*
        *****************************
        *Creacion de la tabla DRIVER*
        *****************************
Esta es la tabla en la que se recogen los datos del conductor
*/

CREATE TABLE DRIVER (
    DNI NUMBER(8),
    DRIVER_NAME VARCHAR2(20) NOT NULL,
    FIRST_SURNAME VARCHAR2(15) NOT NULL,
    LAST_SURNAME VARCHAR2(15),
    PREFERRED_IDIOME VARCHAR2(2) NOT NULL,
    DISCHARGE_DATE DATE NOT NULL,
    CONSTRAINT PK_DRIVER PRIMARY KEY(DNI)
);
/*
        *************************************
        *Creacion de la tabla PLACES_VISITED*
        *************************************
Que se encargará de almacenar la información de los lugares visitados por el conductor asi como la fecha de entrada y salida de estos
*/
CREATE TABLE PLACES_VISITED(
    DRIVER_DNI NUMBER(8),
    PLACE_ID NUMBER(10),
    ENTRY_DATE DATE,
    EXIT_DATE DATE,
    ODOMETER_VALUE NUMBER(7) NOT NULL,
    CONSTRAINT PK_PLACES_VISITED PRIMARY KEY(DRIVER_DNI, PLACE_ID,ENTRY_DATE),
    CONSTRAINT FK_PLACES_VISITED_DRIVER FOREIGN KEY(DRIVER_DNI) REFERENCES DRIVER(DNI),
    CONSTRAINT FK_PLACES_VISITED_PLACES FOREIGN KEY(PLACE_ID) REFERENCES PLACES(PLACE_ID)
);
/*
        **********************************
        *Creación de la tabla DRIVER_WORK*
        **********************************
Esta tabla nace de la relacion N:M entre compañia y trabajador y se encarga de indicar en que momento el trabajador trabaja para una compañia u otra
*/

CREATE TABLE DRIVER_WORK (
    COD_COMPANY NUMBER(4),
    DRIVER_DNI NUMBER(8),
    WORK_START_DATE DATE,
    WORK_FINISH_DATE DATE NOT NULL,
    CONSTRAINT PK_DRIVER_WORK PRIMARY KEY(COD_COMPANY,DRIVER_DNI,WORK_START_DATE),
    CONSTRAINT FK_DRIVERWORK_COMPANY FOREIGN KEY(COD_COMPANY) REFERENCES COMPANY(COD_COMPANY),
    CONSTRAINT FK_DRIVERWORK_DRIVER FOREIGN KEY(DRIVER_DNI) REFERENCES DRIVER(DNI)
);
/*
        ***************************
        *Creacion la tabla VEHICLE*
        ***************************
Esta tabla recoge la informacion de los vehiculos de cada empresa
*/

CREATE TABLE VEHICLE (
    VEHICLE_REGISTER_NUM NUMBER(8),
    VEHICLE_NATION_REGISTER VARCHAR2(10),
    COMPANY_COD NUMBER(4),
    CONSTRAINT PK_VEHICLE PRIMARY KEY(VEHICLE_REGISTER_NUM),
    CONSTRAINT FK_VEHICLE_COMPNAY FOREIGN KEY(COMPANY_COD) REFERENCES COMPANY(COD_COMPANY)
);
/*
        ********************************
        *Creacion la tabla VEHICLE_USED*
        ********************************
Esta tabla tambien es fundamental ya que se encarga de recoger los datos de los vehiculos cuando fueron usados por cuanto tiempo y el valor del cuenta kilometros cuando empezó y cuando acabó.
*/

CREATE TABLE VEHICLE_USED (
    FIRST_USE_DATE DATE,
    LAST_USE_DATE DATE NOT NULL,
    ODOMETER_START NUMBER(8) NOT NULL,
    ODOMETER_FINISH NUMBER(8) NOT NULL,
    VEHICLE_REGISTER_NUM NUMBER(8) NOT NULL,
    DRIVER_DNI NUMBER(8),
    CONSTRAINT PK_VEHICLE_USED PRIMARY KEY (FIRST_USE_DATE),
    CONSTRAINT FK_VEHICLEUSED_VEHICLE FOREIGN KEY(VEHICLE_REGISTER_NUM) REFERENCES VEHICLE (VEHICLE_REGISTER_NUM),
    CONSTRAINT FK_VEHICLEUSED_DIVER FOREIGN KEY(DRIVER_DNI) REFERENCES DRIVER (DNI)
);
/*
        ***************************
        *Creacion de la tabla CARD*
        ***************************
La tabla de la tarjeta se encarga de recoger los datos de las tarjetas de los conductores
*/

CREATE TABLE CARD (
    CARD_ID NUMBER(8),
    EXPIRATION_DATE DATE,
    ACQUISITION_DATE DATE,
    DRIVER_DNI NUMBER(8),
    CONSTRAINT PK_CARD PRIMARY KEY(CARD_ID),
    CONSTRAINT FK_CARD_DRIVER FOREIGN KEY(DRIVER_DNI) REFERENCES DRIVER (DNI)
);

/*
        *******************************
        *Creación de la tabla ACTIVITY*
        *******************************
Esta tabla es la mas importante ya que recoge la actividad del conductor estando en una compañia u otra, así como cuanto tiempo ha trabajado y los descansos realizados.
*/

CREATE TABLE ACTIVITY (
    A_ID NUMBER(5),
    ACTIVITY VARCHAR2(15),
    STATUS VARCHAR2(20),
    REGIME VARCHAR2(20),
    DRIVER VARCHAR2(20),
    TIME DATE,
    COMPANY_COD NUMBER(4),
    DRIVER_DNI NUMBER(8),
    CONSTRAINT PK_ACTIVITY PRIMARY KEY(A_ID),
    CONSTRAINT FK_ACTIVITY_COMPANY FOREIGN KEY(COMPANY_COD) REFERENCES COMPANY(COD_COMPANY),
    CONSTRAINT FK_ACTIVITY_DRIVER FOREIGN KEY(DRIVER_DNI) REFERENCES DRIVER(DNI)
); 
```
</details>


### Restricciones a las tablas

- Añadir una restricción que haga que el idioma preferido del conductor solo puedan ser: ES, EN, FR.

    ```SQL
    ALTER TABLE DRIVER ADD CONSTRAINT CK_IDIOME CHECK(PREFERRED_IDIOME IN('ES','EN','FR')   );
    ```
- Añadir una restricción que haga que el inicio del cuenta kilometros de la tabla vehiculo usado sea menos al final del cuenta kilometros.

    ```sql
    ALTER TABLE VEHICLE_USED ADD CONSTRAINT CK_ODOMETER_VALUE CHECK(ODOMETER_START < ODOMETER_FINISH);
    ```
- Añadir una restricción a la fecha de entrada de la tabla lugares visitados para que esta sea menos a la fecha de salida.

    ```sql
    ALTER TABLE PLACES_VISITED ADD CONSTRAINT CK_ENTRY_EXIT_DATE CHECK(ENTRY_DATE < EXIT_DATE);
    ```
- Cambiar el valor de la tabla lugares y lugares vistados del numero que sea a un NUMBER(6) para que no haya un volumen de datos tan grande.

    ```sql
    ALTER TABLE PLACES MODIFY PLACE_ID NUMBER(6);
    ALTER TABLE PLACES_VISITED MODIFY PLACE_ID NUMBER(6);
    ```
- Añadir una restricción que haga que la fecha de expiración de la tarjeta siempre sea mayor a la de adquisición.
    ```SQL
    ALTER TABLE CARD ADD CONSTRAINT CK_CARD_DATE CHECK(EXPIRATION_DATE < ACQUISITION_DATE);
    ```
- Añadir una restricción que haga que solo se puedan inserta los siguientes datos en la columna actividad de la tabla actividad: PAUSA/DESCANSO,CONDUCIENDO.
    ```SQL
    ALTER TABLE ACTIVITY ADD CONSTRAINT CK_ACTIVITY CHECK(ACTIVITY IN('PAUSA/DESCANSO','CONDUCIENDO'));
    ```
- Añadir una restricción al status de la tabla actividad que haga que solo se puedan poner las siguiente palabras: INSERTADA,NO INSERTADA.
    ```SQL
    ALTER TABLE ACTIVITY ADD CONSTRAINT CK_STATUS CHECK(STATUS IN('INSERTADA','NO INSERTADA'));
    ```
- Añadir una restricción al conductor de la tabla actividad que haga que solo se puedan insertar los siguientes dos valores: SOLITARIO,COOPILOTO.
    ```SQL
    ALTER TABLE ACTIVITY ADD CONSTRAINT CK_DRIVER CHECK(DRIVER IN('SOLITARIO','COOPILOTO'));
    ```
## Insert a las tabla
<details>
    <summary>Clica aquí para ver los inserts realizados</summary>

```sql
/*
        **************************************
        *Insert realizados a la tabla COMPANY*
        **************************************
*/
INSERT INTO COMPANY VALUES(1111,'Proyecto S.L',43030);
INSERT INTO COMPANY VALUES(2222,'Final S.L',45035);
INSERT INTO COMPANY VALUES(3333,'Pre S.A',43075);
INSERT INTO COMPANY VALUES(4444,'Feria C',41230);
/*
        *************************************
        *Insert realizados a la tabla PLACES*
        *************************************
*/
INSERT INTO PLACES VALUES(411111,'Andalucia','España');
INSERT INTO PLACES VALUES(422222,'Barcelona','España');
INSERT INTO PLACES VALUES(433333,'Madrid','España');
INSERT INTO PLACES VALUES(444444,'Villa Baguette','Francia');
INSERT INTO PLACES VALUES(455555,'Carcasona','Francia');
INSERT INTO PLACES VALUES(466666,'Castelo Branco','Portugal');
INSERT INTO PLACES VALUES(477777,'Santa Maria','Portugal');
/*
        *************************************
        *Insert realizados a la tabla DRIVER*
        *************************************
*/
INSERT INTO DRIVER VALUES(12345678,'Pepito','Grillo',NULL,'ES','02-05-2019');
INSERT INTO DRIVER VALUES(87654321,'Paco','Paquito',NULL,'EN','15-04-2019');
INSERT INTO DRIVER VALUES(11234567,'Ivan','Rustof',NULL,'FR','25-04-2019');
/*
        *********************************************
        *Insert realizados a la tabla PLACES_VISITED*
        *********************************************
*/
INSERT INTO PLACES_VISITED VALUES(12345678,411111,'26-06-2019','28-06-2019',55450);
INSERT INTO PLACES_VISITED VALUES(12345678,411111,'27-06-2019',NULL,60360);
INSERT INTO PLACES_VISITED VALUES(12345678,411111,'03-05-2019','06-05-2019',77895);
INSERT INTO PLACES_VISITED VALUES(12345678,455555,'10-05-2019','15-05-2019',83650);
INSERT INTO PLACES_VISITED VALUES(12345678,466666,'16-05-2019','25-05-2019',85780);
INSERT INTO PLACES_VISITED VALUES(12345678,411111,'17-05-2019',NULL,88954);
INSERT INTO PLACES_VISITED VALUES(87654321,433333,'15-07-2019','20-07-2019',40780);
INSERT INTO PLACES_VISITED VALUES(87654321,422222,'20-07-2019','23-07-2019',46890);
INSERT INTO PLACES_VISITED VALUES(87654321,433333,'25-07-2019',NULL,50000);
INSERT INTO PLACES_VISITED VALUES(87654321,433333,'04-05-2019','10-05-2019',77856);
INSERT INTO PLACES_VISITED VALUES(87654321,422222,'11-05-2019','20-05-2019',78452);
INSERT INTO PLACES_VISITED VALUES(87654321,444444,'20-05-2019','29-05-2019',82450);
INSERT INTO PLACES_VISITED VALUES(87654321,422222,'30-05-2019','05-06-2019',86451);
INSERT INTO PLACES_VISITED VALUES(87654321,433333,'10-06-2019',NULL,88954);
INSERT INTO PLACES_VISITED VALUES(11234567,477777,'10-07-2019','13-07-2019',145763);
INSERT INTO PLACES_VISITED VALUES(11234567,466666,'13-07-2019','18-07-2019',149555);
INSERT INTO PLACES_VISITED VALUES(11234567,411111,'18-07-2019','21-07-2019',152364);
INSERT INTO PLACES_VISITED VALUES(11234567,466666,'21-07-2019','23-07-2019',156294);
INSERT INTO PLACES_VISITED VALUES(11234567,477777,'25-07-2019',NULL,160000);
INSERT INTO PLACES_VISITED VALUES(11234567,455555,'02-05-2019','14-05-2019',63564);
INSERT INTO PLACES_VISITED VALUES(11234567,444444,'14-05-2019','27-05-2019',66894);
INSERT INTO PLACES_VISITED VALUES(11234567,422222,'27-05-2019','10-06-2019',68546);
INSERT INTO PLACES_VISITED VALUES(11234567,455555,'25-06-2019',NULL,71654);
/*Insert de prueba para comprobar que la constraint funciona correctamente*/
INSERT INTO PLACES_VISITED VALUES(11234567,455555,'28-06-2019','26-06-2019',71654);
/*
Esta consulta la he utilizado comprobar que la constraint anteriormente puesta en la tabla este funcionando, poniendo como idioma PL.
*/
INSERT INTO DRIVER VALUES(12234567,'Manuel','Programa',NULL,'PL','23-04-2019');
/*
        ***********************************************************
        *Inserts con subconsulta realizados a la tabla DRIVER_WORK*
        ***********************************************************
*/
/*Primer insert*/
INSERT INTO DRIVER_WORK(WORK_START_DATE,WORK_FINISH_DATE,COD_COMPANY,DRIVER_DNI)
    VALUES(
   '25-06-2019','30-06-2019', 
        (SELECT COD_COMPANY
            FROM COMPANY
                WHERE COD_COMPANY=1111),
                    (SELECT DNI
                        FROM DRIVER
                            WHERE DNI=12345678));
/*Segundo insert*/
INSERT INTO DRIVER_WORK(WORK_START_DATE,WORK_FINISH_DATE,DRIVER_DNI,COD_COMPANY)
    VALUES
        ('15-07-2019','25-07-2019',
            (SELECT DNI
                FROM DRIVER
                    WHERE DNI=87654321),
                        (SELECT COD_COMPANY
                            FROM COMPANY
                                WHERE COD_COMPANY=2222));
/*Tercer insert*/
INSERT INTO DRIVER_WORK(WORK_START_DATE,WORK_FINISH_DATE,DRIVER_DNI,COD_COMPANY)
    VALUES
    ('10-07-2019','25-07-2019',
    (SELECT DNI
        FROM DRIVER
            WHERE DNI=11234567),
                (SELECT COD_COMPANY
                    FROM COMPANY WHERE COD_COMPANY=3333));
/*Cuarto insert*/
INSERT INTO DRIVER_WORK(WORK_START_DATE,WORK_FINISH_DATE,DRIVER_DNI,COD_COMPANY)
    VALUES
    ('02-05-2019','25-06-2019',
    (SELECT DNI
        FROM DRIVER
            WHERE DNI=11234567),
                (SELECT COD_COMPANY
                    FROM COMPANY WHERE COD_COMPANY=1111));
/*Quinto insert*/
INSERT INTO DRIVER_WORK(WORK_START_DATE,WORK_FINISH_DATE,DRIVER_DNI,COD_COMPANY)
    VALUES
    ('02-05-2019','10-06-2019',
    (SELECT DNI
        FROM DRIVER
            WHERE DNI=12345678),
                (SELECT COD_COMPANY
                    FROM COMPANY WHERE COD_COMPANY=2222));
/*Sexto insert*/
INSERT INTO DRIVER_WORK(WORK_START_DATE,WORK_FINISH_DATE,DRIVER_DNI,COD_COMPANY)
    VALUES
    ('02-05-2019','29-05-2019',
    (SELECT DNI
        FROM DRIVER
            WHERE DNI=87654321),
                (SELECT COD_COMPANY
                    FROM COMPANY WHERE COD_COMPANY=4444));
/*
        **************************************
        *Insert realizados a la tabla VEHICLE*
        **************************************
*/
INSERT INTO VEHICLE VALUES(11111112,'España',1111);
INSERT INTO VEHICLE VALUES(11111113,'España',1111);
INSERT INTO VEHICLE VALUES(11111114,'España',1111);
INSERT INTO VEHICLE VALUES(22222223,'España',2222);
INSERT INTO VEHICLE VALUES(22222224,'España',2222);
INSERT INTO VEHICLE VALUES(22222225,'España',2222);
INSERT INTO VEHICLE VALUES(33333336,'España',2222);
INSERT INTO VEHICLE VALUES(33333337,'España',3333);
INSERT INTO VEHICLE VALUES(44444448,'España',4444);
INSERT INTO VEHICLE VALUES(44444449,'España',4444);
INSERT INTO VEHICLE VALUES(44444441,'España',4444);
/*
        *******************************************
        *Insert realizados a la tabla VEHICLE_USED*
        *******************************************
*/
INSERT INTO VEHICLE_USED VALUES('25-06-2019','30-06-2019',50560,60360,11111113,12345678);
INSERT INTO VEHICLE_USED VALUES('15-07-2019','25-07-2019',30800,50000,22222224,87654321);
INSERT INTO VEHICLE_USED VALUES('10-07-2019','25-07-2019',140000,160000,33333336,11234567);
INSERT INTO VEHICLE_USED VALUES('02-05-2019','25-06-2019',60651,71654,11111112,11234567);
INSERT INTO VEHICLE_USED VALUES('05-05-2019','10-06-2019',75640,88954,11111113,12345678);
INSERT INTO VEHICLE_USED VALUES('04-05-2019','10-06-2019',75640,88954,44444449,87654321);
/*
        ***********************************
        *Insert realizados a la tabla CARD*
        ***********************************
*/
INSERT INTO CARD VALUES('11122233','01-07-2019','01-06-2019',12345678);
INSERT INTO CARD VALUES('22233344','03-03-2019','02-02-2019',12345678);
INSERT INTO CARD VALUES('55566677','31-05-2019','04-05-2019',12345678);
INSERT INTO CARD VALUES('33344455','02-07-2019','20-06-2019',87654321);
INSERT INTO CARD VALUES('66677788','15-06-2019','03-05-2019',87654321);
INSERT INTO CARD VALUES('77788899','29-07-2019','05-07-2019',11234567);
INSERT INTO CARD VALUES('88899911','15-06-2019','03-05-2019',11234567);
INSERT INTO CARD VALUES('99911122','15-03-2019','10-02-2019',11234567);
/*Insert de prueba para ver que la constraint esta correctamente configurada*/
INSERT INTO CARD VALUES('77788894','10-01-2019','10-02-2019',11234567);
/*
        ***************************************
        *Insert realizados a la tabla ACTIVITY*
        ***************************************
*/
INSERT INTO ACTIVITY VALUES(12345,'PAUSA/DESCANSO','INSERTADA',NULL,'SOLITARIO',TO_DATE('25-06-2019 08:00','DD-MM-YYYY HH:MI'),1111,12345678);
INSERT INTO ACTIVITY VALUES(12346,'CONDUCIENDO','INSERTADA',NULL,'SOLITARIO',TO_DATE('25-06-2019 08:15','DD-MM-YYYY HH:MI'),1111,12345678);
INSERT INTO ACTIVITY VALUES(12344,'PAUSA/DESCANSO','INSERTADA',NULL,'SOLITARIO',TO_DATE('25-06-2019 10:15','DD-MM-YYYY HH:MI'),1111,12345678);
INSERT INTO ACTIVITY VALUES(12343,'PAUSA/DESCANSO','INSERTADA',NULL,'SOLITARIO',TO_DATE('25-06-2019 10:17','DD-MM-YYYY HH:MI'),1111,12345678);
INSERT INTO ACTIVITY VALUES(12342,'CONDUCIENDO','INSERTADA',NULL,'SOLITARIO',TO_DATE('25-06-2019 10:19','DD-MM-YYYY HH:MI'),1111,12345678);
```
</details>


### Updates
- Aumentar en un 20% el valor del cuenta kilometros final de la tabla vehiculos usados cuando el nombre del conductor sea Ivan
```sql
UPDATE VEHICLE_USED
SET ODOMETER_FINISH = ODOMETER_FINISH*1.20
WHERE DRIVER_DNI=(SELECT DNI FROM DRIVER WHERE DRIVER_NAME='Ivan');
```
- Actualizar el valor de la tabla lugares visitados solo cuando el nombre dle conductor sea el de Ivan y el exit date sea NULL.
```sql
UPDATE PLACES_VISITED
SET ODOMETER_VALUE = (SELECT ODOMETER_FINISH FROM VEHICLE_USED WHERE ODOMETER_FINISH > 100000)
WHERE DRIVER_DNI=(SELECT DNI FROM DRIVER WHERE DRIVER_NAME='Ivan') AND EXIT_DATE IS NULL;
```
- Cambiar la nacion de registro de los vehiculos a Francia cuando el nombre de la compañia sea Pre S.A.
```SQL
UPDATE VEHICLE
SET VEHICLE_NATION_REGISTER = 'Francia'
WHERE COMPANY_COD=(SELECT COD_COMPANY FROM COMPANY WHERE COMPANY_NAME='Pre S.A');
```

### Deletes

- Borrar el registro de la tabla trabajo del conductor cuando la compañia sea Final S.L y el nombre del conductor sea Pepito
```SQL
DELETE FROM DRIVER_WORK 
WHERE COD_COMPANY=(SELECT COD_COMPANY FROM COMPANY WHERE COMPANY_NAME LIKE 'Final S.L') AND DRIVER_DNI=(SELECT DNI FROM DRIVER WHERE DRIVER_NAME LIKE 'Pepito');
```
- Borrar el registro de la tabla lugares visitados cuando el nombre de la region sea Villa Baguette y la fecha de salida sea igual a 29-05-2019.
```sql
DELETE FROM PLACES_VISITED
WHERE PLACE_ID=(SELECT PLACE_ID FROM PLACES WHERE REGION LIKE 'Villa Baguette') AND EXIT_DATE='29-05-2019';
```
- Borrar los registros de la tabla places_visited donde el nombre del conductor sea Paco y la fecha de entrada este comprendida entre 05-05-2019 y 20-05-2019.
```SQL
DELETE FROM PLACES_VISITED
WHERE DRIVER_DNI=(SELECT DNI FROM DRIVER WHERE DRIVER_NAME LIKE 'Paco') AND ENTRY_DATE > '05-05-2019' AND ENTRY_DATE < '20-05-2019';
```
### Consultas y Subconsultas

- Seleccionar el nombre de los conductores que tengan mas de una tarjeta.
```sql
SELECT DRIVER_NAME
    FROM CARD, DRIVER
        WHERE CARD.DRIVER_DNI=DRIVER.DNI
            GROUP BY DRIVER_NAME
                HAVING COUNT(DRIVER_DNI)>1;
```
- Seleccionar el nombre de los conductores los cuales tienen tarjeta caducadas a dia de hoy.
```sql
SELECT DRIVER_NAME
    FROM CARD, DRIVER
        WHERE CARD.DRIVER_DNI=DRIVER.DNI AND EXPIRATION_DATE < SYSDATE;
```
- Seleccionar el nombre de las compañias cuando la nacion de registro sea Francia o el codigo de compañia sea 4444.
```sql
SELECT COMPANY_NAME
    FROM COMPANY
        WHERE COD_COMPANY 
            IN(SELECT COMPANY_COD
                FROM VEHICLE
                    WHERE VEHICLE_NATION_REGISTER
                        LIKE 'Francia'
                            OR COMPANY_COD=4444);
```
- Seleccionar el nombre de la compañia que tiene el ultimo uso del cuanta kilometros mas alto.
```sql
SELECT COMPANY_NAME
    FROM COMPANY
        WHERE COD_COMPANY=(SELECT COMPANY_COD
                                FROM VEHICLE
                                    WHERE VEHICLE_REGISTER_NUM=(SELECT VEHICLE_REGISTER_NUM
                                                                    FROM VEHICLE_USED
                                                                        WHERE ODOMETER_FINISH=(SELECT MAX(ODOMETER_FINISH)
                                                                                                    FROM VEHICLE_USED)));

```
- Mostrar el nombre del conductor que haya trabajado mas de una vez con la misma compañia.
```sql
SELECT DRIVER_NAME
    FROM DRIVER_WORK,DRIVER
        WHERE DRIVER.DNI=DRIVER_WORK.DRIVER_DNI
            GROUP BY DRIVER_NAME
                HAVING COUNT(DISTINCT COD_COMPANY)=1;
```
- Mostrar el nombre de las regiones las cuales han sido visitadas por mas de un conductor.
```sql
SELECT REGION
    FROM PLACES
        JOIN PLACES_VISITED
            ON PLACES.PLACE_ID = PLACES_VISITED.PLACE_ID
                GROUP BY REGION
                    HAVING COUNT(DRIVER_DNI)>1;
```
- Mostrar el nombre de la compañia y el numero de registro del vehiculo cuando el valor del cuenta kilometros del ultimo uso de un vehiculo sea igual al valor del cuenta kilometros de la tabla lugares visitados.
```sql
SELECT C.COMPANY_NAME,VEHICLE_USED.VEHICLE_REGISTER_NUM
    FROM VEHICLE_USED
        JOIN VEHICLE
            ON VEHICLE_USED.VEHICLE_REGISTER_NUM=VEHICLE.VEHICLE_REGISTER_NUM
                JOIN COMPANY C
                    ON VEHICLE.COMPANY_COD=C.COD_COMPANY
                        JOIN PLACES_VISITED P
                            ON VEHICLE_USED.ODOMETER_FINISH=P.ODOMETER_VALUE
                                GROUP BY C.COMPANY_NAME,VEHICLE_USED.VEHICLE_REGISTER_NUM;
```
- Seleccionar la media del cuanta kilometros de la tabla lugares visitados.
```SQL
SELECT AVG(ODOMETER_VALUE)
    FROM PLACES_VISITED;
```
- Contar el numero de vehiculos que tiene cada compañia.
```sql
SELECT COMPANY_NAME,COUNT(VEHICLE_REGISTER_NUM) AS Numero_Vehiculos
    FROM COMPANY, VEHICLE
        WHERE COMPANY.COD_COMPANY=VEHICLE.COMPANY_COD
            GROUP BY COMPANY_NAME;
```
- Mostrar el nombre del conductor y el nombre de la region la cual haya sido visitada mas de 2 veces.
```sql
SELECT DRIVER_NAME,PLACES.REGION
    FROM DRIVER
        JOIN PLACES_VISITED
            ON DRIVER.DNI = PLACES_VISITED.DRIVER_DNI
                JOIN PLACES
                    ON PLACES.PLACE_ID = PLACES_VISITED.PLACE_ID
                        GROUP BY DRIVER_NAME,PLACES.REGION
                            HAVING COUNT(PLACES.REGION)>2;
```

### Vistas

- Crear una vista que permita visualizar el nombre del trabajador y el numero de tarjetas que tiene tanto caducadas como validas.

```sql
CREATE VIEW NUMERO_TARJETAS AS
    SELECT DRIVER_NAME, COUNT(CARD_ID)AS Numero_tarjetas
        FROM DRIVER, CARD
            WHERE DRIVER.DNI=CARD.DRIVER_DNI
                GROUP BY DRIVER_NAME;
```
- Crear una vista que permita visualizar el nombre de compañia y la cantidad de vehiculos que tiene.
```sql
CREATE VIEW NUMERO_VEHICULOS AS
    SELECT COMPANY_NAME, COUNT(VEHICLE_REGISTER_NUM) AS Numero_vehiculos
        FROM COMPANY, VEHICLE
            WHERE COMPANY.COD_COMPANY=VEHICLE.COMPANY_COD
                GROUP BY COMPANY_NAME;
```
- Crear una vista que permita visualizar el nombre de la compañia y la cantidad de vehiculos que estan siendo usados en el mes que actual.
```sql
CREATE VIEW VEHICULOS_MAYO AS
    SELECT C.COMPANY_NAME,COUNT(V.VEHICLE_REGISTER_NUM) AS Numero_vehiculos_usados
        FROM COMPANY C, VEHICLE V,VEHICLE_USED VU
            WHERE C.COD_COMPANY=V.COMPANY_COD
                AND V.VEHICLE_REGISTER_NUM=VU.VEHICLE_REGISTER_NUM
                    AND TO_CHAR(FIRST_USE_DATE, 'month')=TO_CHAR(SYSDATE, 'month')
                        GROUP BY C.COMPANY_NAME;
```

### Creacion de las tablas en MONGODB

```json
db.COMPANY.insert({
    "COD_COMPANY":[
        1111,
        2222,
        3333,
        4444
        ],
    "COMPANY_NAME":[
        "Proyecto S.L",
        "Final S.L",
        "Pre S.A",
        "Feria C"
        ],
    "CP":[
        43030,
        45035,
        43075,
        41230
        ]
    }
)

db.PLACES.insert({
    "place_id":[
    	411111,
		422222,
		433333,
		444444,
		455555,
		466666,
		477777
	],
	"region":[
		"Andalucia",
		"Barcelona",
		"Madrid",
		"Villa Baguette",
		"Carcasona",
		"Castelo Branco",
		"Santa Maria"
	],
	"country":[
		"España",
		"España",
		"España",
		"Francia",
		"Francia",
		"Portugal",
		"Portugal"
	]
}

```