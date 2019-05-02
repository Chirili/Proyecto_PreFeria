# Proyecto Pre-Feria

## Indice

### Idea Principal
La idea principal sobre el proyecto de pre-feria es hacer la estructura de una base de datos de un tacógrafo digital.

### ¿Y que es un tacógrafo digital?
Un tacógrafo digital es un aparato electrónico que se encarga de registrar eventos en la conducción de vehiculos, su precursor fué el tacógrafo analógico, el cuál esta previsto que desaparezca completamente por el digital.

### Funcionamiento del tacógrafo
El tacógrafo digital obtiene datos relativos a los tiempos de conducción y descansos del conductor. Esta información es la más importante de todas y constituye el sentido fundamental del tacógrafo.

### Datos que recoge el tacógrafo.
Los eventos recogidos por el tacógrafo incluyen:
- Conducción, descanso, otros trabajos.
- Excesos de velocidad.
- Errores en el sistema.
- Conducción sin tarjeta.
- Transferencias de datos: estos datos son almacenados tanto en la memoria del tacógrafo como en la de la tarjeta.

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

> NOTA:
 >> En los lugares se necesita saber en que región se encuentra el conductor en dicho momento y la actividad se utiliza para saber todos lo que esta haciendo un conductor en un determinado momento. EJ: conductor X esta de descanso a las 10:00 y a las 10:05 esta conduciendo. Por lo tanto tenemos todos lo datos del conductor asi como el vehiculo que ha usado y a que compañia pertenece.

### Creación de las tablas

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
La primera tabla en crearse es la de COMPANY
Esta primera tabla y la cabeza del trabajo es la recoge la informacion de la compañia en la que trabajan los conductores
*/
CREATE TABLE COMPANY (
    COD_COMPANY NUMBER(4),
    COMPANY_NAME VARCHAR2(20) NOT NULL,
    CP NUMBER(5) NOT NULL,
    CONSTRAINT PK_COMPANY PRIMARY KEY(COD_COMPANY)
);
/*
Segunda tabla en crearse es la tabla PLACES
En esta tabla se recogen los lugares a los que viaja el conductor.
*/

CREATE TABLE PLACES (
    PLACE_ID NUMBER(10),
    REGION VARCHAR(20),
    COUNTRY VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_PLACES PRIMARY KEY(PLACE_ID)
);
/*
Tercera tabla en crearse es la tabla DRIVER
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
Cuarta tabla en crearse es la tabla PLACES_VISITED
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
Quinta tabla en crearse es la tabla CDRIVER_WORK
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
Sexta tabla en crearse es la tabla VEHICLE
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
Septima tabla en crearse es la tabla CVEHICLE_USED
Esta tabla tambien es fundamental ya que se encarga de recoger los datos de los vehiculos cuando fueron usados por cuanto tiempo y el valor del cuenta kilometros cuando empezó y cuando acabó.
*/

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
/*
Octava tabla en crearse es la tabla CARD
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
Novena y ultima tabla en crearse es la tabla CACTIVITY
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
