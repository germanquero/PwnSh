# Unix Shell
#### PwnSh: Sesion 1.2
-----

## Introduccion
La Unix Shell aparecio en 1971 desarollada por Ken Thompson. Desde entonces es la base sobre la que se ha construido la gran mayoria del software.

Es muy util aprender a utilizar la shell de manera eficiente, ya que es donde pasamos la mayoria de nuestro tiempo como pentesters, analistas, desarolladores o entusiastas de la ciberseguridad y la tecnologia.

Un conocimiento definiciente sobre el uso de la shell puede llevar a la falsa creencia de que hay tareas imposibles o requieren scripts largos y complejos, cuando lo cierto es, que al igual que con python u otros lenguajes, la gran mayoria de cosas se pueden hacer en un *oneliner*.

Por todos estos motivos en PwnSh hemos decidido comenzar por aqui, explorando la shell y profundizando en el extenso mundo del Bash.


## Comandos basicos
### Manejo de ficheros
#### CD
```shell
cd directorio
```
Por defecto (si no se especifica directorio) cd toma por defecto "~" (directorio HOME del usuario actual).

Los subdirectorios se pueden anidar: directorio/subdirectorio/subsubdirectorio/etc/

Si quisieramos movernos al directorio padre habria que hacer cd a "..".
Y funciona con el anidamiento: ../../../ (en este caso: tres directorios mas atras).

Para volver al ultimo directorio visitado se puede hacer cd a "-".

#### LS
Se ejecuta de la siguiente manera:
```shell
ls directorio
```
Por defecto (si no se especifica directorio) ls toma por defecto "."(directorio actual)
Se le pueden especificar varios directorios uno detras del otro y listara el contenido de ellos.

**Flags:**
- l : modo lista (muestra informacion mas detallada: permisos, propietario, hora de ultima edicion, tamaño)
- a : muestra todos los archivos (incluidos los ocultos, que en sistemas linux son los que comienzan por un ".")
- h : humaniza el tamaño de los ficheros (mostrandolo en KB, MB, GB, etc)
- --color : resalta los tipos de archivo con distintos colores

*Ejemplo:*
```shell
ls -lah --color direcotrio/
```

*(Si te mola como se ve esto, te recomiendo* lsd *, un paquete practicamente igual a ls con* -h --color *por defecto y un paquete de iconos bastante chulo)*
*(Tambien te recomiendo* tree *, un paquete que muestra directorios y archivos en formato arbol, muy util para visualizar)*

#### PWD
Se ejecuta de la siguiente manera:
```shell
pwd
```
No tiene flags ni argumentos ni flags, simplemente retorna la direccion absoluta del directorio actual.

#### TOUCH
Se ejecuta de la siguiente manera:
```shell
touch nombre_de_archivo
```

Crea un archivo o archivos con los nombres especificados.

#### MKDIR
Se ejecuta de la siguiente manera:
```shell
mkdir nombre_de_directorio
```
Crea un directorio o directorios con los nombres especificados
Con el flag -p creara los direcotios padres especificados en caso de que no existan.

#### RM
Se ejecuta de la siguiente manera:
```shell
rm archivo
```
Elimina el archivo o archivos especificados
**Flags:**
- r : modo recursivo (al especificarle un directorio elimina recursivamente todo su contenido si el directorio en si)
- f : modo forzoso (elimina cualquier cosa sin solicitar confirmacion)
- i : modo interactivo (te pregunta fichero a fichero si quieres eliminarlo)

Tecnicamente esto borra lo que sea siempre y cuando tengas permisos para ello:
```shell
rm -rf direcotrio archivo lo_que_quieras
```

#### RMDIR
Se ejecuta de la siguiente manera:
```shell
rmdir directorio
```
Basicamente es rm para directorios. Se diferencia de rm -r en que no es recursivo. Es decir, solo elimina directorios vacios. Es mas seguro para tratar con ficheros importantes.

#### MV
Se ejecuta de la siguiente manera:
```shell
mv archivo ruta/
```
Mueve el fichero especificado a la ruta especificada.

Si al mover especificas un nuevo nombre de archivo lo renombras:
```shell
mv archivo ruta/nuevo_nombre
```
**OJO:** Si el fichero existe lo sobreescribe!!

**Flags**:
- i : modo seguro (pregunta antes de sobreescribir).
- u : tan solo sobreescribe si el archivo origen es mas moderno que el destino (util para automatizar).

#### CP
Funciona exactamente igual que mv solo que copia en lugar de mover el archivo.
*Ejemplo:*
```shell
cp -i archivo ruta/
```

#### CAT
Se ejecuta de la siguiente manera:
```shell
cat archivo
```
Muestra el contenido del archivo o archivos especificados.

Con -n muestra el numero de linea.

#### LESS
Se ejecuta de la siguiente manera:
```shell
less archivo
```
Muestra el contenido del archivo especificado dentro de un entorno con scroll.

Se sale con la Q o Esc.
Con / puedes buscar.
Tiene mas controles y comandos de busqueda muy similares a vi.

*(Si te gustaria que tuviera sintaxis, colores y una apariencia mejor prueba *bat *, es basicamente less y cat integrados con sintaxis y numeros de linea)

### Gestion de Procesos
#### PS
Se ejecuta de la siguiente manera:
```shell
ps
```
Por defecto muestra los procesos del usuario que lo ejecuta.

**Flags:**
- e : muestra procesos de todos los usuarios.
- f : muestra los procesos con mas detalle.
- u usuario : muestra los procesos del usuario especificdo.

**Ejemplo:**
```shell
ps -fu root
```

#### TOP
Se ejecuta de la siguiente manera:
```shell
top
```
Por dejecto muestra todos los procesos.

**Flags:**
- d N : especifica una tasa de refresco en segundos.
- u usuario : muestra los procesos del usuario especificado.
- p PID,PID,PID, ... : filtra por PIDs

Interactividad (pulsando teclas en ejecucion):
- k : mandar señal kill, aparece un prompt donde introducir un PID
- m : mostrar la memoria de forma distinta o no mostrarla directamente.
- M : ordenar los procesos por memoria
- n : definir un numero maximo de procesos que mostrar 
- N : ordenar por PID
- t : mostrar el uso de CPU y el numero de tasks de formas distintas o no.
- T : ordenar por tiempo
- P : ordenar por uso de cpu

*(Si te gustaria que tuviera mejor interantividad y apariencia prueba *htop*)


