---?color=linear-gradient(to right, #000000, #242523)

@snap[midpoint h2-heading h3-name]
## Proyecto Pre-Feria
### &mdash; Andrés Carmona Lozano &mdash;
@snapend

---?color=linear-gradient(to right, #242523, #9F9F9F)

@snap[west span-40]
@box[idea](Idea principal#La idea principal sobre el proyecto de pre-feria es hacer la estructura de una base de datos de un tacógrafo digital)
@snapend

@snap[east span-40]
@box[idea](¿Y que es un tacógrafo digital?# Un tacógrafo digital es un aparato electrónico que se encarga de registrar eventos en la conducción de vehiculos, su precursor fué el tacógrafo analógico, el cuál esta previsto que desaparezca completamente por el digital.)
@snapend

---
@snap[north-west span-40 funcionamiento]
@box[idea](Funcionamiento#El tacógrafo digital obtiene datos relativos a los tiempos de conducción y descansos del conductor. Esta información es la más importante de todas y constituye el sentido fundamental del tacógrafo.)
@snapend

@snap[south-east span-60 datos]
@box[idea](Datos#Los eventos recogidos por el tacógrafo incluyen:)
@ul[funcionamiento_lista](false)

    - Conducción, descanso, otros trabajos.
    - Excesos de velocidad.
    - Errores en el sistema.
    - Conducción sin tarjeta.
    - Transferencias de datos: estos datos son almacenados tanto en la memoria del tacógrafo como en la de la tarjeta.
@ulend
@snapend

@snap[south-west]
@css[entidad_relacion](Modelo Entidad-Relacion)
@snapend
@snap[south-west d3-flecha]
@fa[arrow-down]
@snapend

+++

@snap[north entidad span-95]
## Modelo Entidad-Relación
@snapend

@snap[midpoint entidadimg]
![Modelo-Entidad_Relacion](src/images/modelo_entidad_relacion.jpg)
@snapend

@snap[east relacional_1]
@css[relacional](Modelo Relacional)
@snapend
@snap[east relacional_2]
@fa[arrow-right]
@snapend


@gitlink[TEXT](https://github.com/Chirili/Proyecto_PreFeria/blob/master/src/statements/problema.md)


@snap[west-sidebar problema]
@gitlink[TEXT](src/statements/problema.md)
@snapend
---

@snap[north entidad span-95]
## Modelo Relacional
@snapend


![Modelo Relacional](src/images/modelo_relacional.jpg)


@snap[south-west d5-text]
@css[entidad_relacion](Create table)
@snapend
@snap[south-west d5-flecha]
@fa[arrow-down prueba]
@snapend


---

@snap[north span-40]
### Creación de las tablas y programas usados
@snapend
@snap[west span-40]
@box[windows](Windows#Principalmente el proyecto se ha realizado en windows con Oracle como gestor de base de datos y SQLDeveloper como entorno de desarrollo)
@snapend
@snap[east span-40]
@box[linux](Linux#La parte secundaria y para terminar de adornar el proyecto he utilizado ubuntu 19.04 como sistema operativo y oracle como gesto de base de datos, SQLPlus como conector hacia la base de datos y Asciinema, el cual es un programa que permite grabar terminales y despues mediante un video mostrarla y poder copiar el contenido de la misma mientras se va escribiendo)
@snapend