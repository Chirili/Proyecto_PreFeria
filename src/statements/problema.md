# [Volver a la presentación](https://gitpitch.com/Chirili/Proyecto_PreFeria#/2/1)

## Descripción del problema

Se necesita almacenar en la base de datos, los datos relacionados con un tacógrafo digital:

   - Se almacenará los datos de la compañia, el conductor, el vehiculo y el vehiculo usado, actividad, lugares y tarjeta.

   - De la compañía se almacenará **(el codigo, nombre de la compañia y el codigo postal).**

        > Hay que tener en cuenta que una compañia puede tener muchos conductores y un conductor puede trabajar con distintas compañias pero nunca con dos a la vez.

   - Del conductor interesa saber su **(DNI, nombre, primer y segundo apellido, el idioma preferido y la fecha de alta en la empresa).**

   - De la actividad se almacenará  **(el ID, el estado, el régimen, conducto y el tiempo).**
        > Teniendo en cuenta que la actividad la realiza un conductor cada ID de actividad tiene que tener asociado un DNI de un conductor que esta realizando esa actividad asi como el codigo de compañia a la que pertenece dicho conductor en ese determinado momento

    - Del vehiculo interesa saber **(el número de registro y la nación de registro de dicho vehiculo, asi como el código de la compañía a la que pertenece).**

        > Un vehiculo solo puede pertener a una empresa y una empresa puede tener tantos vehiculo.

    - Del vehiculo usado necesitamos **(el numero de registro del vehiculo, el dni del conductor que lo ha usado, el comienzo y fin del cuenta kilometros y el primer y último uso de dicho vehiculo).**

    - De los lugares interesa saber **(La fecha de entrada y salida de dicho lugar, el país, la región, y el valor del cuenta kilometros tanto cuando entra como cuando sale).**

    - La tarjeta tiene que tener **(Un ID de tarjeta, la fecha de expiración y la fecha de adquisición de la misma y por último el DNI del conductor que la está usando ).**
        > Hay que tener en cuenta que un conductor solo debe tener una tarjeta operativa al mismo tiempo, es decir, que si tiene mas de una tarjeta es porque las demás estan caducadas.

> NOTA:
 >> En los lugares se necesita saber en que región se encuentra el conductor en dicho momento y la actividad se utiliza para saber todos lo que esta haciendo un conductor en un determinado momento. EJ: conductor X esta de descanso a las 10:00 y a las 10:05 esta conduciendo. Por lo tanto tenemos todos lo datos del conductor asi como el vehiculo que ha usado y a que compañia pertenece.
    