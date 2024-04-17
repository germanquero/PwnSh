# Unix Shell
#### PwnSh: Sesion 1.2
-----

## Introduccion
La Unix Shell Aparecio en 1971 desarollada por Ken Thompson. Desde entonces es la base sobre la que reside la gran mayoria del software.

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
Y funciona con el anidamiento: ../../../ (tres directorios mas atras).

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



