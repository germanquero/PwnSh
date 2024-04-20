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
- k : mandar señal kill, aparece un prompt donde introducir un PID y el tipo de señal que enviar (9 para softkill, 15 para hardkill)
- m : mostrar la memoria de forma distinta o no mostrarla directamente.
- M : ordenar los procesos por memoria
- n : definir un numero maximo de procesos que mostrar 
- N : ordenar por PID
- t : mostrar el uso de CPU y el numero de tasks de formas distintas o no.
- T : ordenar por tiempo
- P : ordenar por uso de cpu

*(Si te gustaria que tuviera mejor interantividad y apariencia prueba *htop*)

#### KILL
Se ejecuta de la siguiente manera:
```shell
kill PID
```
Basicamente mata el proceso especificado.

Se puede, igual que en top, especificar el tipo de señal enviada con -9 o -15. Puedes ver todas las señales permitidas con -l.

#### KILLALL
Se ejecuta de la siguiente manera:
```shell
killall nombre
```

Mata todos los procesos con el nombre especificado.
Con -s N se puede especificar la señal que enviar como en los comandos anteriores. Se pueden listar las dispnibles con -l.


#### PGREP
Se ejecuta de la siguiente manera:
```shell
pgrep patron
```

Busca procesos segun el patron especificado:
- nombre : filtra seugn el nombre del proceso 
- -u usuario,usuario,... : filtra segun los usuarios especificados

Con -l podemos pedirle que muestre el nombre del comando completo a parte del PID.

*Ejemplo:*
```shell
pgrep python -u root -l
```

#### PKILL
Se ejecuta de la siguiente manera:
```shell
pkill patron
```

Basicamente es la version de pgrep que mata procesos en lugar de buscarlos.

### Gestion de usuarios
#### SU
Se ejecuta de la siguiente manera:
```shell
su usuario
```

Sirve para logearse con otro usuario desde la terminal

De esta forma, arrancaria tambien su entorno de inicio (directorio de inicio, configuracion y variables):
```shell
su - usuario
```

#### SUDO
Se ejecuta de la siguiente manera:
```shell
sudo comando
```

Permite ejecutar un comando como root.
Tambien se puede especificar un usuario distinto a root con -u usuario.

Los permisos para ejecutar este comando se configuran en /etc/sudoers con el editor de texto visudo para evitar problemas de seguridad.

#### USERADD
Se ejecuta de la siguiente manera:
```shell
useradd nombre
```

Añade un usuario con el nombre de usuario indicado.
Existen multitud de **flags** para especificar datos sobre el usuario:
- -m : crea el directorio /home/usuario lo establece como el $HOME.
- -s shell : permite especificar la shell.
- -G grupo,grupo,grupo : permite especificar los grupos a los que pertenece.
- -c descripcion : permite añadir una descripcion.
- -u UID : permite especificar el UID
- -d dir : especifica el $HOME si no se ha utilizado -m.

*Ejemplo:*
```shell
sudo useradd nuevo -m /user/bin/zsh -G wheel -c "nuevo usuario en el sistema" -u 1234
```

#### USERDEL
Se ejecuta de la siguiente manera:
```shell
userdel usuario
```

Basicamente elimina usuarios del sisitema.

Con -r se elimina el $HOME y todos los archivos subyacentes.

#### PASSWD
Se ejecuta de la siguiente manera:
```shell
passwd
```

Sirve para establecer o modificar la contraseña del usuario que lo ejecuta.

Como root puedes especificar el usuario.
Tambien puedes obligarle a cambiarla en su proximo login con -e:
```shell
passwd -e usuario 
```

#### USERMOD
Se ejecuta de la siguiente manera:
```shell
usermod usuario modificaciones
```

Permite realizarle modificaciones a la informacion del usuario mediante:
- -aG grupo,grupo,.. : añade al usuario a los grupos indicados
- -G grupo,grupo,grupo,.. : sobreescribe los grupos del usuario con los indicados
- -d path/ : cambia el $HOME del usuario.
- -l nombre : cambia el nombre del usuario
- alguno mas para el resto de la informacion (consultar el man)

#### GROUPS
Se ejecuta de la siguiente manera:
```shell
groups usuario
```

Muestra los grupos a los que pertenece un usuario.

#### GROUPADD, GROUPDEL
Se ejecutan de la siguiente manera:
```shell
groupadd grupo
groupdel grupo
```

Añaden y eliminan grupos del sistema respectivamente.

#### NEWGROUP
Se ejecuta de la siguiente manera:
```shell
newgroup grupo
```

Permite a un usuario moverse temporalmente a un grupo.

## Gestion del flujo y Redireccion de datos
Controlar el flujo de los procesos, su input y output, y la comunicacion entre ellos y la automatizacion de todo esto es lo que puede hacer mucho mas eficaz y eficiente nuestra experiencia dentro de una shell.

Por ello vamos a ver como se controla el flujo, luego como se redireccionan los datos y por ultimo algunos comandos y componentes especiales que facilitan el trabajo.


### Flujo de procesos
#### &&
Dentro de nuestra shell, el operador logico AND sirve para hacer literalmente un comando Y el siguiente.

Si el primer comando acaba correctamente, se ejecutara el siguiente, si el primer comando falla por algun motivo, el segundo no se realizara.

*Ejemplo:*
```shell
mkdir directorio & echo "directorio creado"
```

Si por algun motivo (que ya exista o no tengamos permisos) no se pudiese crear el directorio, podriamos ver que no se imprime el mensaje.

#### &
Si quisiesemos ejecutar independientemenete un comando de otro, podriamos utilizar un solo &.
*Ejemplo:*
```shell
touch fichero.txt & mkdir directorio
```
Esto tratara de crear tanto el fichero como el directorio independientemente de si ha podido crear fichero.txt.

Realmente lo que hace es enviar a segundo plano el primer proceso. Dejando el primer plano al segundo, no ejecuta uno y luego otro, si no con paralelismo.
Puedes comparar la diferencia asi:
*Ejemplo:*
```shell
sleep 4 && echo "Has esperado 4 segundos."
sleep 4 & echo "Espera 4 segundos...."
```

De la misma forma puedes utilizar un & al final de cualquier comando para pasarlo a segundo plano igual:
```shell
firefox &
```

De esta forma el proceso correria en segundo plano y mantendriamos el control de la terminal.

#### CTRL+Z:
Sirve para suspender un programa en seguno plano.

De forma similar al &, sobre un proceso corriendo, podemos presionar Ctrl+Z y esto enviara a segundo plano el proveso.

En lugar de dejarlo corriendo, lo deja suspendido en espera de volver a primer plano.

#### FG
Se ejecuta de la siguiente manera:
```shell
fg
```

Sirve para traer a primer plano el proceso en segundo plano.

#### BG
Se ejecuta de la siguiente manera:
```shell
bg
```

Sirve para continuar en segundo plano un proceso suspendido.

*Ejemplo:*
```shell
firefox
(Ctrl+Z) (la ventana de firefox deberia ser inutil)bg (deberia volver a funcionar ahora)
```

#### PIPES
Los pipes son probablemente una de las herramientas mas utilizadas de todas las que vamos a dar.

El funcionamiento es sencillo: envia el output del primer comando como el input del segundo comando.
Se indica de la siguiente manera:
```shell
comando2 | comando2
```

Es muy util con los comandos de filtrado, busqueda y ordenamiento que vamos a ver mas adelante.

### Redireccion de Datos

