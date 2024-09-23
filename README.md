# Proyecto Final – Bases de Datos III
**Implementación de una Solución OLAP**  
**Desarrollado por:** Juan Esteban Díaz Aragón y Jimena Cruz Martínez

## 1. Selección de Negocio
Se eligió el tipo de negocio de transporte entre las tres propuestas, ya que llamó más la atención además que uno de los compañeros tiene cierta experiencia con este.

## 2. Diseño de la Base de Datos Transaccional
Primero se eligió el tipo de negocio para de ahí empezar con la lógica para darle forma a la base de datos transaccional que sea algo compleja pero tampoco tanto, para que tuviera sentido y además albergara datos importantes. Por lo tanto, la base de datos se crea con el nombre de **TransporteBuses** y con las siguientes tablas:

### Modelo de la Base de Datos
De acuerdo con el tipo de negocio, se planteó el siguiente modelo de base de datos:

- **Tabla de Buses:**
  - Atributos: bus_id, placa, modelo, capacidad, estado.
  - Llave primaria: bus_id.

- **Tabla de Conductores:**
  - Atributos: conductor_id, nombre, apellido, licencia, telefono.
  - Llave primaria: conductor_id.

- **Tabla de Rutas:**
  - Atributos: ruta_id, origen, destino, distancia_km.
  - Llave primaria: ruta_id.

- **Tabla de Viajes:**
  - Atributos: viaje_id, ruta_id, bus_id, conductor_id, fecha_salida, fecha_llegada.
  - Llave primaria: viaje_id.
  - Llaves foráneas:
    - ruta_id de la tabla Rutas.
    - bus_id de la tabla Buses.
    - conductor_id de la tabla Conductores.

- **Tabla de Boletos:**
  - Atributos: boleto_id, viaje_id, asiento, precio, fecha_compra.
  - Llave primaria: boleto_id.
  - Llave foránea: viaje_id de la tabla Viajes.

- **Tabla de Pagos:**
  - Atributos: pago_id, boleto_id, monto, fecha_pago, metodo_pago.
  - Llave primaria: pago_id.
  - Llave foránea: boleto_id de la tabla Boletos.

### Relaciones Entre las Tablas
Las relaciones entre las tablas se definen mediante las llaves foráneas que antes ya se vieron, pero a continuación se explica mejor esta parte.

- Un bus puede estar asignado a varios viajes, pero un viaje solo puede tener un bus específico.
- Un conductor puede estar asignado a varios viajes, pero un viaje solo tiene un conductor.
- Una ruta puede estar relacionada con varios viajes.
- Un boleto está vinculado a un único viaje, pero un viaje puede tener múltiples boletos.
- Un pago corresponde a un boleto, pero puede haber varios métodos de pago.

Para este proceso de construcción de la base de datos, no surgió ningún problema durante el desarrollo, fue un proceso normal para lograr que las tablas tuvieran lógica y se relacionaran correctamente. Los Query usados en SSMS se pueden encontrar en el repositorio dentro de la carpeta de Scripts y los diagramas en la carpeta del mismo nombre. Y sobre la configuración TCP/IP, el servidor de SQL Server está habilitado para conexiones remotas utilizando este protocolo. La configuración correcta del puerto y la habilitación del protocolo son cruciales, por lo tanto, se habilitaron sin problema.

## 3. Diseño del Cubo OLAP
Para el diseño del cubo OLAP, primero se creó un Dataware House dentro de la misma instancia, pero en otra base de datos llamada **DW_TransporBuses**, usando un estilo de diagrama estrella. Contiene una tabla principal de hechos llamada **Ventas** y con 5 dimensiones en total, continuamente se explica mejor el modelado:

### Modelado del Dataware House

#### Tabla de Dimensión Tiempo: DimTiempo
Esta tabla almacena las diferentes componentes del tiempo (fecha, día, mes, año, trimestre, semana) que se utilizarán para analizar los datos en distintas dimensiones temporales.
- Columnas:
  - fecha_id: Identificador único de la fecha.
  - fecha: Representa la fecha completa.
  - dia: Día del mes.
  - mes: Mes del año.
  - año: Año correspondiente.
  - trimestre: Trimestre del año (1, 2, 3, 4).
  - semana: Número de semana en el año.
  - dia_semana: Nombre del día de la semana (por ejemplo, 'Lunes').

Esta dimensión permite analizar las ventas y viajes por periodos específicos como días, meses o semanas.

#### Tabla de Dimensión Viaje: DimViaje
Almacena los detalles de los viajes realizados, incluyendo el estado de cada viaje.
- Columnas:
  - viaje_id: Identificador único de cada viaje.
  - bus_id: Identificador del bus (relacionado con la dimensión DimBus).
  - conductor_id: Identificador del conductor (relacionado con la dimensión DimConductor).
  - ruta_id: Identificador de la ruta (relacionado con la dimensión DimRuta).
  - fecha_salida: Fecha y hora de salida del viaje.
  - fecha_llegada: Fecha y hora de llegada del viaje.
  - estado_viaje: Estado del viaje (completado, cancelado, en curso).

Esta tabla permite analizar el desempeño de los viajes, el estado de estos y relacionarlos con ventas y otras dimensiones.

#### Tabla de Dimensión Ruta: DimRuta
Almacena los detalles de las rutas de transporte.
- Columnas:
  - ruta_id: Identificador único de la ruta.
  - origen: Ciudad de origen de la ruta.
  - destino: Ciudad de destino de la ruta.
  - distancia_km: Distancia entre origen y destino en kilómetros.

Esta dimensión permite analizar las rutas más rentables, las distancias recorridas y la popularidad de los destinos.

#### Tabla de Dimensión Bus: DimBus
Almacena información sobre los buses utilizados en el sistema de transporte.
- Columnas:
  - bus_id: Identificador único del bus.
  - placa: Placa del bus.
  - modelo: Modelo del bus.
  - capacidad: Número máximo de pasajeros que puede transportar.
  - estado: Estado actual del bus (disponible, en mantenimiento, en ruta).

Esta dimensión permite analizar la utilización de los buses, su estado y capacidad.

#### Tabla de Dimensión Conductor: DimConductor
Almacena información sobre los conductores de los buses.
- Columnas:
  - conductor_id: Identificador único del conductor.
  - nombre: Nombre del conductor.
  - apellido: Apellido del conductor.
  - licencia: Número de la licencia de conducir.
  - telefono: Número de teléfono de contacto del conductor.

Esta dimensión permite analizar la participación de los conductores en los viajes y su relación con las ventas y la satisfacción del cliente.

#### Tabla de Hechos Ventas: Ventas
Esta tabla almacena las métricas claves relacionadas con las ventas de boletos de cada viaje. Es el punto central del Data Warehouse y conecta las dimensiones para permitir un análisis detallado.
- Columnas:
  - venta_id: Identificador único de la venta.
  - viaje_id: Relacionado con la dimensión DimViaje.
  - ruta_id: Relacionado con la dimensión DimRuta.
  - fecha_id: Relacionado con la dimensión DimTiempo.
  - bus_id: Relacionado con la dimensión DimBus.
  - conductor_id: Relacionado con la dimensión DimConductor.
  - monto_vendido: Monto total de la venta.
  - asientos_vendidos: Cantidad de asientos vendidos en el viaje.

Posterior a la creación del Dataware House, se continúa con la implementación del Cubo OLAP, para la cual se utilizó un proyecto en Visual Studio usando uno Multidimensional con Business Intelligence y Analysis Services. Para esto anteriormente la instancia se instaló con la opción de Analysis Services añadida y con developer para que se pueda habilitar que esta sea multidimensional y entonces dentro del Visual Studio pueda crearse el cubo gracias a que este proyecto es específico para esto. El tipo de proyecto se llama: **Proyecto Multidimensional de Analysis Services**.  
[Video Guía](https://www.youtube.com/watch?v=VO9K6kaGedU&t=659s)

Usando el anterior video como guía, se siguieron los pasos y se usó una autenticación de SQL usando el usuario sa. Al final se logra crear el cubo siguiendo los pasos del video, que básicamente fueron crear un origen de datos, las vistas de este origen, el cubo y editar sus dimensiones, para que al final se procesara todo y datos de la instancia se conectara correctamente. Y básicamente este fue el proceso seguido, parece sencillo, pero a continuación se describirán los desafíos encontrados en esta parte.

### Desafíos Encontrados
- **Autenticación:** Existen las autenticaciones de Windows y SQL para conectarse a la instancia a la hora de iniciar con el proceso de creación del cubo en Visual Studio. Esta parte fue el principal error que nos estaba generando el no poder procesar el cubo cuando el resto de los pasos se hacían, ya que a pesar de que permite elegir entre estas dos autenticaciones, el usar Windows era lo que nos impedía conectarnos de manera correcta al servidor. Y para lograr con el resultado, antes de saber que ese era el principal error, se probaron muchas cosas, que al mismo tiempo nos fueron ayudando a entender cómo se conectan los componentes y para qué sirve cada uno.

- **Conexiones de Origen de Datos:** Al principio no se identificaban las tablas correctas en el origen de datos o se configuraban incorrectamente las conexiones a las bases de datos. Fue un proceso de prueba y error, donde se revisaron las conexiones y la lógica detrás de ellas.

## 4. Desarrollo del Portal Web
Descargamos todo lo necesario según videos para la creación de un Portal Web con ASP.NET, y esto fue lo primero que intentamos, crearlo todo desde cero, pero después de un rato nos decidimos por clonar un repositorio de un login ya hecho para poder usarlo y nosotros implementar el resto de las funcionalidades adaptándolo a este. 

Entonces se clonó el repositorio, también creamos a la base de datos que se necesitaba para el funcionamiento, pero la adaptamos a nuestras necesidades, que básicamente consiste en una tabla donde ingresamos usuarios manualmente para que esta se conecte con el login y los métodos en el SQL validen las encriptaciones de las contraseñas y sus roles. La base de datos o su script, se va a ver en el repositorio en el archivo de Scripts.

Ahora con esto listo, se explica la siguiente arquitectura del proyecto resumidamente. El portal está construido utilizando ASP.NET Web Forms, lo cual define una arquitectura Cliente-Servidor que sigue una separación entre la lógica de la aplicación y la interfaz gráfica. A continuación, se describe la arquitectura:

### 1. Capa de Presentación (Frontend)
- Las páginas .aspx son la capa de presentación, donde se define la interfaz de usuario. Cada archivo .aspx tiene un archivo de código subyacente (.aspx.cs) y un archivo de diseño (.aspx.designer.cs).
- Las vistas contienen la lógica de la interfaz, que permite a los usuarios interactuar con el sistema, por ejemplo, el inicio de sesión (Login_InfoToolsSV.aspx), administración (admin.aspx), y panel de gerente (gerente.aspx).

### 2. Capa de Negocio (Business Logic)
- El código detrás (.aspx.cs) implementa la lógica de negocio, como validación de usuarios, interacción con la base de datos, y otros procesos empresariales necesarios para el portal.

### 3. Capa de Datos (Data Access Layer)
- El acceso a la base de datos se realiza a través de conexiones establecidas en los archivos de configuración (Web.config), donde se define la cadena de conexión a un servidor SQL.
- Esta capa interactúa directamente con la base de datos para recuperar y almacenar información.

### 4. Manejo de Sesiones y Seguridad
- El archivo Web.config gestiona aspectos como la seguridad, autenticación y autorización de usuarios, asegurando que sólo usuarios autenticados puedan acceder a ciertas páginas o funcionalidades del portal.

### 5. Capa de Compilación y Paquetes
- Las carpetas bin y obj contienen los ensamblados del proyecto y archivos compilados, lo que permite que el proyecto sea ejecutado.
- La carpeta packages incluye dependencias externas gestionadas a través de NuGet, facilitando la integración de librerías de terceros.

Resumidamente este portal tiene puntos importantes que queremos recalcar, que es el desarrollo para que dependiendo del usuario pueda ingresar a la ventana acorde a sus permisos, y que esto se conecte directamente con los distintos servidores de las bases de datos específicas para la utilización de sus respectivos datos, además de usar el cubo OLAP.

### Administrador
El rol del Administrador tiene el acceso más amplio dentro del portal. Este usuario puede gestionar completamente los datos y el cubo OLAP, así como realizar modificaciones y actualizaciones. Las principales funcionalidades implementadas para el Administrador son:
- **Gestión del Cubo OLAP:** El Administrador puede crear, modificar y eliminar el cubo OLAP. Esto incluye la capacidad de agregar nuevas dimensiones y medidas, así como ajustar las existentes.
- **Actualización de Datos:** Puede cargar nuevos datos al sistema, modificar los existentes y actualizar las fuentes de datos del cubo OLAP.
- **Configuración del Sistema:** Puede ajustar la configuración general del sistema, como la autenticación, control de acceso, y otras configuraciones críticas para la seguridad y el rendimiento.

### Gerente
El Gerente tiene un rol intermedio, con acceso principalmente orientado a la consulta de datos y generación de reportes predefinidos. Las funcionalidades clave para el Gerente incluyen:
- **Consultas Predefinidas:** El Gerente puede ejecutar consultas predefinidas sobre el cubo OLAP para obtener datos relevantes para la toma de decisiones. Estas consultas están diseñadas para facilitar el análisis sin necesidad de conocimientos técnicos profundos.
- **Visualización de Reportes Gráficos:** El sistema genera gráficos basados en las consultas predefinidas, permitiendo al Gerente visualizar los resultados de manera clara y comprensible. Los gráficos incluyen tendencias, comparaciones de ventas, análisis de rendimiento, entre otros.
- **Descarga de Informes:** El Gerente puede descargar informes generados a partir de las consultas, tanto en formatos PDF como Excel, para compartir con otros departamentos o utilizar en presentaciones.

### Analista de Datos
El Analista de Datos tiene un rol avanzado en términos de análisis de información. Su acceso le permite generar nuevos análisis y reportes a partir de los datos disponibles en el cubo OLAP. Las funcionalidades implementadas para este rol incluyen:
- **Creación de Nuevos Análisis:** El Analista de Datos puede crear sus propios análisis personalizados utilizando las dimensiones y medidas disponibles en el cubo OLAP. Esto permite una flexibilidad total para explorar la información y descubrir nuevas tendencias o patrones.
- **Exportación de Datos:** El Analista tiene la capacidad de exportar los datos resultantes de sus análisis en CSV para compartirlos o hacer análisis adicionales fuera del sistema.

### Autenticación y Control de Acceso
El portal web implementa un sistema robusto de autenticación y control de acceso basado en roles. Cada usuario debe iniciar sesión para acceder a sus funcionalidades asignadas. Los permisos están claramente definidos para garantizar que los usuarios solo tengan acceso a las herramientas y datos que les corresponden, minimizando riesgos de seguridad y errores operativos.

### Desafíos
Los principales desafíos para esta parte fueron:
1. **Conexiones de Datos:** Primero nos fallaron mucho las cadenas de datos de String para conectarnos a las instancias, por nombres o el uso de Provider Name que era el incorrecto, al final esta parte se logró solucionar.
2. **Filtración por Roles:** Lo siguiente fue la filtración por roles al usar el login, ya que el sistema se caía o no avanzaba a la siguiente vista. También se pudo lograr de manera efectiva y dependiendo del rol y su contraseña, ingresa correctamente a la interfaz que este tenga de base.
3. **Interfaces de Cada Rol:** Y el desafío más grande era lograr que las interfaces de cada rol sirviera como tal, que tuvieran funcionalidades para lograr con el enunciado de cada uno. Al final se intentó hasta donde se pudo, tratando de darle lógica a cada vista para los roles, pero no se logró hacer que funcionaran de acuerdo con lo requerido por los enunciados.

## Conclusión
Como conclusión se logró todo lo antes documentado, y además se ve mejor explicado durante el video de 10 minutos requerido en la entrega. Al final de todo, se aprendió mucho sobre el uso de SQL Server en herramientas como SSMS, SSAS, el Visual Studio 2022, la creación de cubos y cómo es que verdaderamente funcionan, también de cómo manejar mejor GitHub y páginas web, a pesar de no lograr con totalidad lo requerido, se concluye con un gran aprendizaje y experimentación en zonas que no se habían tocado mucho antes.
