# SHELL
- [SHELL](#shell)
  - [Introduccion](#introduccion)
    - [Historia e Importancia](#historia-e-importancia)
    - [Comandos basicos](#comandos-basicos)
      - [Bases](#bases)
      - [Navegacion y gestion de ficheros](#navegacion-y-gestion-de-ficheros)
      - [Gestion de procesos](#gestion-de-procesos)
    - [Gestion del flujo y redireccion de datos](#gestion-del-flujo-y-redireccion-de-datos)
      - [Procesos](#procesos)
      - [Datos](#datos)
      - [Comandos y dispositivos utiles](#comandos-y-dispositivos-utiles)
    - [Gestion de Usuarios](#gestion-de-usuarios)
      - [Usuarios y grupos](#usuarios-y-grupos)
      - [Permisos de archivos y directorios](#permisos-de-archivos-y-directorios)
    - [Historial](#historial)
      - [Comandos](#comandos)
      - [Parametros](#parametros)
  - [Manejando mejor el output y los ficheros](#manejando-mejor-el-output-y-los-ficheros)
    - [Detalles de cada comando](#detalles-de-cada-comando)
      - [GREP](#grep)
      - [SED](#sed)
      - [AWK](#awk)
      - [FIND](#find)
      - [SORT - UNIQ - HEAD - TAIL - TR- WC](#sort---uniq---head---tail---tr--wc)
    - [Como trabajan entre ellos](#como-trabajan-entre-ellos)
  - [Conclusion](#conclusion)
  - [Reversas - Remotas - Manejo de TTY:](#reversas---remotas---manejo-de-tty)
    - [Shell del Host:](#shell-del-host)
    - [Shell Remota:](#shell-remota)
    - [Adaptar la terminal:](#adaptar-la-terminal)
  - [Practica - Herramienta Enumeracion (arp-scan + nmap)](#practica---herramienta-enumeracion-arp-scan--nmap)

## Introduccion
### Historia e Importancia
La shell es el entorno de trabajo comun de la mayoria de programadores, ingenieros informaticos, ingenieros de software, pentesters, expertos en ciberseguridad, hackers y muchos otros profesionales del ámbito tecnológico. 
Es una de las piezas de software mas viejas, nacidas en 1971 en la primera Unix Shell desarollada por Ken Thomson en 1971. Es sin duda la mas importante y ha sido el catalizador de muchisimo desarollo dentro del apartado software (es la base sobre la que reside la mayoria).

Aunque las CLIs ya no dominen el apartado de interaccion con el usuario y es conocido que una GUI es mejor alternativa para usuarios nuevos e inexperimentados, el control de la shell y sus comandos sigue siendo una habilidad esencial y muy poderosa para cualquier profesional o entusiasta del campo de la informatica.

Dominar los comandos, trucos, combinaciones de teclas, palabras reservadas y atajos propios de la shell puede llegar ahorrar una cantidad de tiempo muy sigificativa cuando tu profesion orbita entorno a trabajar dentro de una.

No solo eso, un conocimiento definiciente sobre el uso de la shell puede llevar a la falsa creencia de que hay tareas imposibles o requieren scripts largos y complejos, cuando lo cierto es, que al igual que con python u otros lenguajes, la gran mayoria de cosas se pueden hacer en un *oneliner*.

Por todos estos motivos en PwnSh hemos decidido comenzar por aqui, explorando la shell y profundizando en el extenso mundo del Bash.
### Comandos basicos
#### Bases
- ./ = representa el directorio en el que se encuentra la shell
- ../ = representa el directorio padre de un directorio (es concatenable *'../../../'*)
- ~/ ($HOME) = representa el valor de la variable $HOME para el usuario. Normalmente (/home/usuario/)
- / = es la raiz del sistema. Cualquier direccion que comience asi se considera absoluta
- La mayoria de comandos que capturan la entrada salen con la q o el esc
- El tabulador completa con ficheros, con algunos comandos y plugins funciona con parametros pero no siempre.
- Algunos caracteres se tienen que escapar como los - a principio de un string o los espacios. El tabulador suele autoescapar.
- man {comando} o {comando} -h suele ser una forma rapida de aprender a usar cualquier comando.
#### Navegacion y gestion de ficheros
- ls {dir:opcional}
  - Lista el contenido del directorio {dir}
  - Por defecto: ls .
  - -l : modo lista -> muestra permisos, propietario, tamaño y fecha de modificacion
  - -a: muestra todos los archivos, incluidos los ocultos (los que empiezan por .)
  - -h: cambia los tamaños de bits a algo legible (KB, MB, GB, etc)
  - --color: resalta los tipos de archivo con distintos colores
  - *Ejemplo: ls -lsh --color /*
  - Paquete alternativo: lsd (iconos y --color y -h por defecto)
- cd {dir:opcional}
  - Situa la shell en el directorio {dir}
  - Por defecto: cd ~
  - cd -: vuelve al ultimo directorio visitado
- pwd
  - Devuelve la direccion en la que se encuentra la shell
- touch {nombre}
  - Crea un archivo vacio de nombre {nombre}
- mkdir {nombre}
  - Crea un directorio vacio de nombre {nombre}
  - -p: crea los directorios padres si no existen
- rm {fichero}
  - Borra el fichero
  - -r: borra directorios y todo su contenido
  - -f: borra sin solicitar confirmacion
  - *Entonces: rm -rf borra lo que sea*
- rmdir {dir}
  - Borra el directorio
  - A diferencia de rm -r solo borra directorios si estan vacios.
  - El unico pro esque en ese sentido es mas seguro (no borrar archivos sin querer vaya).
- mv {fichero/dir} {ruta}
  - Mueve el fichero o directorio a la ruta seleccionada
  - Si la ruta acaba en / se mantiene el nombre de archivo
  - Si la ruta acaba en un nombre de archivo nuevo renombra
  - **OJO!**:: Si el fichero existe lo sobreescribe
    - Se puede evitar con el flag -i
  - -u: solo se mueve el archivo si no sobreescribe o si el de destino es mas viejo
- cp {fichero/dir} {ruta}
  - Copia el fichero o directorio a la ruta seleccionada
- cat {fichero}
  - Muestra el contenido de un fichero
  - -n: muestra el numero de lineas
  - Paquete alternativo: bat (cat+less con sintaxis y esteroides)
- less {fichero}
  - Muestra el contenido en un entorno con scroll
#### Gestion de procesos
- ps
  - Muestra procesos activos
  - Por defecto: procesos del usuario
  - -e: procesos de todos los usuarios
  - -f: mas detalle
  - -u {usuario}: especificar un usuario
- top
  - Muestra procesos y consumo de recursos
  - d {int}: especifica tasa de refresco en segundos
  - u {usuario}: especifica usuario
  - p {pid,pid,pid,...}: filtra por ciertos ids de proceso
  - Paquete alternativo: htop(mas bonito e interactivo)
- pgrep
  - -u {usuario} Mata todos los procesos del usuario especificado
  - -f {patron} Mata todos los procesos que coincidan con el patron
- kill {id}
  - Mata el proceso especificado
  - {id}: el PID del proceso a finalizar
  - -9: señal de finalizacion inmediata
  - -15: señal de finalizacion suave
  - -l: muestra lista de señales
- killall {nombre}
  - Mata todos los procesos con el nombre especificado
- pkill
  - La version que mata procesos en lugar de buscar de pgrep
### Gestion del flujo y redireccion de datos
#### Procesos
Los comandos basicos te pueden llevar hasta cierto punto con una terminal.
Realmente puedes hacer casi todo de forma manual con nano y CopyPaste.
Pero lo que te lleva realmente a explotar al completo sus funciones es controlar el flujo de los procesos, asi como su input y output.
Lo basico seria lo siguiente:
- Mediante && puedes concatenar commandos, de forma que si el primero termina de forma correcta, se ejecute el segundo y asi sucesivamente
  - Ejemplo: mkdir test && cd test && touch a.txt && cat a.txt
- Mediante el uso de un solo & al final de un comando puedes enviarlo a segundo plano y dejarlo a la espera y retomar el control de la terminal:
  - *Ejemplo: man htop &*
  - Con esto nuestra terminal se quedaria como si nada, pero si miramos *ps* encontraremos varios procesos man
  - Podemos traerlo a primer plano otra vez con *fg*
  - El trabajo se queda suspendido esperando, con bg puedes hacer que continue corriendo en segundo plano.
- Mediante Ctrl + Z puedes parar cualquier proceso de la misma forma que si hubieras puesto & al final.
- Mediante | puedes crear Pipes: un concepto de programacion que implica enviar la salida de un comando a la entrada del siguiente
  - *Ejemplo: echo "hola que tal estas?" | wc -w -> output: 4*
  - *wc* es un comando que cuenta palabras con -w y lineas con -l
  - *Ejemplo 2:* "si hola que tal estas?" fuese el contenido de test.txt podrias:
    - *cat test.txt | wc -w*
#### Datos
- {comando} \> {file}: redirige la salida a un archivo sobreescribiendolo
  - Esto da lugar a un truco: *> {file}* es lo mismo que *touch {file}*
- {comando} \>\> {file}: añade la salida al final archivo
- {comando} 2\> {flie}: refirige la salida de error hacia un archivo
- {comando} \>\> {file} 2\>&1: refirige la salida y la de error hacia un mismo archivo
- {comando} &\> {file}: lo mismo que el anterior pero solo funciona en algunas versiones
- {comando} < {file}: redirige la entrada desde un archivo (demomento no he encontrado casos donde sea realnente muy necesario)
#### Comandos y dispositivos utiles
- tee {fichero, fichero, fichero, ...}: copia la entrada que le llegue a la salida estandard aparte de a uno o mas ficheros pasados como parametro.
  - Muy util con pipes en lugar de utilizar tanto \> o \>\>
  - ls -l | tee lista_ficheros.txt | less
  - Por defecto sobreescribe como \> con el flag -a añade igual que \>\>
- xargs: toma cada linea de entrada y aplica el comando.
  - Por ejemplo: *ls | cat* imprime lo mismo que *ls*
    - Esto se debe a que interpreta la salida de ls como un string y te lo imprime
    - Sin embargo *ls | xargs cat* interpretaria cada linea de salida del ls como un argumento separado y aplicaria a cada uno.
    - El flag -i permite especificar donde situarlo del comando de esta forma:
      - mkdir test && ls | xargs -i cp {} test/
Existe un dispositivo /dev/null que podriamos llamar fichero basura o agujero negro en los entornos Linux. Es muy util para deshacerte de salida innecesaria.
Por ejemplo: cualquier_comando \>\> /dev/null 2\>&1 tenga o no el comando modo --silent o --nonverbose o algo por el estilo no va a mostrar output.
Muy util en scripts donde manejar el input y output se puede poner complicado.
### Gestion de Usuarios
#### Usuarios y grupos
- No hay un comando para listar usuarios en linux pero es tan sencillo como cat /etc/passwd y fijarte en la columna de la izquierda.
- su {usuario}
  - Logearse como otro usuario desde terminal
  - si haces *su - {usuario}* arranca su entorno de inicio (directorio y variables)
- sudo {comando}
  - Permite realizar un comando como el usuario root
  - Tambien se puede especificar otro usuario con -u {usuario}
    - Esto lo hace atraves de root, portanto no necesitas contraseña de ese usuario si no de root
- useradd {usuario}
  - Añade un usuario al sistema
  - -m: crea el /home/{usuario} a la vez y lo establece como $HOME
  - -s {shell}: especifica la shell del usuario
  - -G {grupo, grupo, grupo}: especifica los grupos
  - -c {descripcion}: agrega descripcion al usuario
  - -u {UID}: especifica el UID de un usuario
  - -d {dir}: especifica el $HOME del usuario
- passwd
  - Añade o edita contraseña del usuario que lo ejecuta
  - Como root se puede especificar passwd {usuario}
  - -e: obliga al usuario a cambiar su contraseña en el proximo inicio de sesion
- userdel {usuario}
  - Elimina un usuario del sistema
  - -r: elimina el $HOME del usuario y todos sus archivos subyacentes
- usermod {usuario}
  - Modifica propiedades de un usuario
  - -aG {grupo, grupo, grupo}: añade a grupos
  - -G {grupo, grupo}: sobreescribe los grupos
  - -d {dir}: cambia el $HOME del usuario
  - -l {nombre}: cambia el nombre
- groups {usuario}
  - Lista los grupos a los que pertenece un usuario
- groupadd {grupo}
  - Crea un nuevo grupo en el sistema
- groupdel {grupo}
  - Elimina un grupo del sistema
- gpasswd {grupo}
  - Permite ponerle contraseña a un grupo
  - -a {usuario} para añadir un usuario a un grupo con contraseña
  - -d {usuario} para eliminar un usuario a un grupo con contrasñea
  - -A {usuario} para establecer un administrador de grupo
- newgroup {grupo}
  - Permite moverte temporalmente a un grupo (como el su de los grupos)
#### Permisos de archivos y directorios
Existen 3 formas de escribir los permisos:
- Numerico:
  - Consta de 3 numeros del 1 al 7:
    - El primer numero son los permisos del propietario
    - El segundo numero son los permisos del grupo
    - El tercer numero representa los permisos para el resto
  - El numero se calcula teniendo en cuenta:
    - Lectura = 4
    - Escritura = 2
    - Ejecucion = 1
  - Por tanto:
    - 0: ningun permiso
    - 1: solo permisos de ejecucion
    - 2: solo permisos de escritura
    - 3: permisos de escritura y ejecucion
    - 4: solo permisos de lecutra
    - 5: permisos de lecutra y ejecucion
    - 6: permisos de lecutra y escritura
    - 7: todos los permisos 
- ls:
  - 9 caracteres, sets de 3 en 3, de la misma forma que habia 3 cifras en el formato numerico
  - las letras son r para lectura (read), w para escritura (write) y x para ejecucion. Los '-' significan sin permiso
Comandos para alterar grupos y permisos:
- chown {propietario:grupo} {archivo/dir}
  - Cambia el propietario o grupo de un fichero o directorio
  - -R para aplicarlo recursivamente a directorios
- chgrp {grupo} {archivo/dir}
  - chown solo para grupos
- chmod {permisos} {archivo/dir}
  - Especifica permisos para un archivo o directorio
  - -R para aplicarlo recursivamente a directorios
  - los permisos se pueden especificar en formato numerico o mediante:
    - \[ u (usuario), g (grupo), o (resto) \]\[ +, -, =\][r, w, x]
    - *Ejemplos: chmod u=rwx,g=x,o=  fichero,  chmod u+x fichero*
- umask {permisos}
  - Establece los permisos predeterminados de creacion de archivos para un usuario.
  - Los permisos se especifican mediante el sistema numerico
### Historial
#### Comandos
'!' se utiliza para acceder a comandos anteriores.
Se puede acceder al ultimo comando realizado mediante:
```shell
user@host:~$ !!
```
Es util cuando se realiza un comando con algun error, cuando se quiere realizar el mismo comando con distintas caracteristicas (substitute) o para aplicarle sudo.
```shell
user@host:~$ systemctl status servicio
user@host:~$ sudo !!
sudo systemctl status servicio
[sudo] password for user:
Servicio is down.
user@host:~$ !!:s/status/start/
sudo systemctl start servicio
```
Como se puede ver arriba mediante :s/patron/substituto podemos aplicarle cambios al comando.
Tambien se puede acceder al historial mediante *history*. Y mediante !N podemos acceder a un  comando en concreto de el:
```shell
user@host:~$ history
(...)
483 bash
484 ls
485 echo a
user@host:~$ !485
ls
Desktop Downloads Templates Public Documents Music Pictures Videos
```
Esto esta bien, pero...¿cómo podriamos ahorrar tiempo?
Supongamos el siguiente caso: Necesitamos acceder a el comando que realizaste hace 3.
Con lo que sabemos hasta ahora necesitariamos hacer lanzar history, mirar el numero del comando y llamar a !n siendo n el numero.
Sin embargo podriamos hacer:
```shell
user@host:~$ !-3
``` 
Si no estas muy seguro de que el comando que vas a ejecutar, se puede añadir :p al final de cualquiera de lo q hemos visto hasta ahora: !!:p , !n:p , !-n:p
Esto va a hacer que no se ejecute el comando, sin embargo lo mostrara por pantalla y entrara en el historial, de forma que si si es el que buscabas, puedes hacer !!.
```shell
user@host:~$ !-5:p
echo a
user@host:~$ !!
echo a
a
```
#### Parametros
El UID del ultimo proceso reside en:
```shell
user@host:~$ sleep 60 &
[1] 2754
user@hsot:~$ kill $!
[1] + terminated    sleep 60
```
Para acceder a los los paramtros del ultimo comando se puede emplear:
```shell
user@host:~$ touch script1.sh script2.sh
user@host:~$ chmod +x !*
chmod +x script1.sh script2.sh
```
Para acceder tan solo al primer comando se puede:
```shell
user@host:~$ touch script1.sh text.txt
user@host:~$ chmod +x !^
chmod +x script1.sh
```
Para acceder al ultimo parametro se puede:
```shell
user@host:~$ mkdir awd dir
user@host:~$ cd !$
user@host:dir$
```
De otra forma $_ es el ultimo parametro utilizado en el ultimo comando:
```shell
user@host:~$ mkdir awd dir 
user@host:~$ cd $_
user@host:dir$
```
Es normal pensar al principio que $_ y !$ son lo mismo. La diferencia se entiende asi:
- $_ es un parametro de shell y !$ es un simbolo reservado de history. (prueba a realizar los dos y buscarlos en history, los comandos con $_ aparecen tal cual, los comando con $! son traducidos)
- $_ es el ultimo parametro del ultimo comando realizado. !$ es el ultimo parametro encontrado en el historial.
¿Qué  significa eso? Hay apartados que bash no considera parametros de un comando, como la redireccion del output, por ejemplo. Sin embargo la redireccion se aloja en el historial y si es accesible por !$.
```shell
user@host:~$ echo a > b.txt
user@host:~$ cat $_
cat: a: No such file or directory
user@host:~$ echo a > b.txt
user@host:~$ cat !$
a
```
## Manejando mejor el output y los ficheros
Ya tenemos una base bastante fundamentada sobre como se comporta nuestra shell y conocemos que se puede gestionar el flujo de forma que un comando se comunique con el siguiente y con ficheros.
Como vimos en ese apartado esa es la forma de optimizar nuestro trabajo dentro de la shell.
Por este motivo es importante profundizar en concreto en algunos comandos.
En mi opinion estos son:
- grep
- sed
- awk
- find
- sort
- cut
- uniq
- tr
- head
- tail
- wc
Se tratan de una serie de comandos de busqueda y manipulacion de texto, tanto ficheros como la salida de los comandos mediante pipes.
Con esto podemos filtrar la salida de los comandos para obtener exactamente lo que queremos de forma que el siguiente comando lo entienda a la perfeccion.
Algunos de estos comandos como puede ser awk tienen un nivel de complegidad extensisimo (awk especificamente parece un lenguaje de programacion casi).
Por ese motivo es muy util profundizar en ellos y conocer cuales son los puntos fuertes de cada uno.
Todo lo que pueden hacer estos comandos probablmenete lo puede hacer awk el solo, pero es mucho mas comodo conocerlos todos y pasar el output entre ellos.
### Detalles de cada comando
#### GREP
Grep es una herramienta concebida para buscar patrones en archivos de texto. Su nombre viene de Global Regluar Expresion Print.
Se utiliza de la siguiente manera:
```shell
grep [opciones] [patron] [archivos]
```
Tambien se puede utilizar mediante pipes sobre el output de otro comando:
```shell
comando | grep [opciones] [patron]
```
Si el output es una lista de archivos, como grep permite esa funcionalidad recuerda que solo hay que adaptarlo mediante xargs:
```shell
ls | xargs grep [opciones] [patron]
```
- Opciones comunes:
  - -i : ignora las mayusculas y minusculas
  - -v : busqueda inversa
  - -r : busca de manera recursiva dentro de directorios
  - -n : muestra el numero de linea
  - -l : muestra solo los nombres de los archivos que contienen coincidencias
  - -c : muestra solo el numero de lineas que coinciden
  - -E : utiliza expresiones regulares extendidas para el patron
  - -F : trata el patron como un string en lugar de una expresion regular
- Patron:
  - El patron se escribe como expresiones regulares.
  - Las expresiones regulares son un tema complejo que excede lo necesario para usar grep comodamente. Se merece su propio tema.
#### SED
Es una herramienta que recorre un archivo y aplica ciertas acciones.
Su nombre viene de StreamEDitor.
Su funcionamiento es el siguiente:
```shell
sed [opciones] [comando] [archivos]
comando | sed [opciones] [comando]
ls | xargs sed [opciones] [comando]
```
Las opciones posibles son:
- -i: realiza los cambios en el archivo directamente en lugar de imprimir el resultado por salida estandard
- -e: pernite especificar multiples comandos de sed en una sola llamada
- -n: suprime la salida automatica de cada linea al ser procesada. Solo las especificadas por el comando se imprimiran
Los comandos mas comunes son:
- buscar y reemplazar: sed 's/patron/reemplazo/Ig' archivo
  - g es opcional. Si esta aplica los cambios a nivel global, si no solo a la primera coincidencia.
  - I es opcional. Hace que no sea sensible a las mayusculas
  - patron: patron de busqueda, puede ser un reGex.
  - reemplazo: texto que deseas que reemplace al patron.
  - Se puede utilizar para añadir texto al principio o al final de todas las lineas mediante $(final) y ^(principio)
    - sed 's/^/texto añadido al principio/' archivo
    - sed 's/$/ texto añadido al final/' archivo
  - con y en lugar de con s se aplica g directamente
- eliminar linea: sed '/patron/Id' archivo
  - elimina las lineas que coincidan con el patron
  - I es opcional. Hace que no sea sensible a las mayusculas
  - Por ejemplo puedes borrar todas las lineas vacias emdiante:
    - sed '/^$/d' archivo
- añadir linea: sed '/patron/{a,i}\Nuevo texto' archivo
  - Añade antes (i) o despues (a) de la linea que coincida con el patron una nueva linea con el Nuevo texto
  - Si quieres editar la linea direcamente y añadir texto antes o despues del patron, lo puedes hacer buscando y reemplazando con el operando &
    - sed 's/patron/reemplazo&/g' archivo
    - sed 's/patrong/&reemplazo' archivo
Por lo general tiene bastantes cosas y nos permite aplicar ciertos cambios en funcion de busquedas.
#### AWK
Es una potentisima herramienta de procesamiento de texto.
Podriamos verlo como un lenguaje de programacion que asume un bucle por cada linea de input.
Se basa en busqueda por patrones y aplicar una accion a cada coincidencia.
Se parece un mogollon a sed, pero la verdad que es mucho mas potente sobretodo cuando se trata de archivos con cierto formato como pueden ser los csv o los logs.
Por lo general es mucho mas potente como buscador que grep y mucho mas potente que sed aplicando acciones sobre las coincidencias. Me parece importante conocer un poco de sed y grep precisamente por lo overkill de awk en muchas ocasiones.

Su funcionamiento viene recordando a las otras 2 herramientas:
```shell
awk [opciones] '[patron] {[accion]}' [archivo]
```

Este comando se basa en 2 secciones, el patron y la accion.
El patron es basicamente grep en esteroides, introduces un patron y filtra las lineas segun las que coincidan con dicho patron. Acepta variables, comparaciones == regex y muchas mas cosas. Tambien es util conocer que tiene END y BEGUIN.

La accion se basa en separadores, por defecto es espacio pero se puede definir con -F- Una vez separada la linea cada columna viene representada por $N, siendo $0 toda la linea $1 el prier argumento y asi.

Tambien tiene variables propias como: NR para el numero de linea (record number), NF (sizeof($0)). Se puede hacer $NF para imprimir el ultimo valor sin conocer el tamaño previamente o si es variable.

Tiene un lenguaje muy parecido a C para definir la logica de las acciones. Se pueden definir bucles y logica compleja asi como realizar opraciones tipicas (por ejemplo: sqrt(6345))

Tambien es importante destacar que se puede:
```shell
awk [opciones] '[patron1] {[accion1]} [patron2] {[accion2]} ...' [archivo]
```
De forma que la accion 1 se ejecute cuando coincida con el patron 1 y asi sucesivamente. Esto, trabajando con variables puede ser muy util.
Por ejemplo: imaginate que quieres que antes de imprimir una linea que contiene "hola paco" quieres comprobar que no haya otra mas adelante llamada "adios paco". Esto podriamos hacerlo independientemente del nombre de la siguiente manera:
```shell
awk '$1 == "hola"' {saludado[$2] = 1} $1 == "adios" {if (saludado[$2] == 1){delete saludado[$2]}} END {print "Gente que llego y no se fue: "; for (persona in saludado) {printf ("%s ", persona)}}'
```
En general es muy potente y con regex, condicionales, bucles y variables pues realmente se puede hacer lo que sea. En general todo lo que hagas con cualquier comando de esta seccion con multiples pipes lo puedes hacer con un solo awk. Si te quieres poner fricki es la mas potente y la que mas recomiendo.

Sin embargo recomiendo mucho practicar a hacer distintas cosas: sacarlo todo con un awk, sacar todo lo que puedas solo con grep sed y cut, probar cual es la manera mas eficiente mediante pipes en lugar de mediante flags complicadas.

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

#### SORT - UNIQ - HEAD - TAIL - TR- WC
En trim defines 2  separadores y separa el contenido entre los primeros separadores y los separa con los segundos.
*Por ejemplo: Separar un texto por palabras en distintas lineas:*
```shell
cat archivo.txt | tr " " "\n"
```
Ese comando de arriba es muy util para trabajar con otros comandos de esta seccion. Por ejemplo:

Sort basicamente ordena, tiene glags -n para numericamente, -M que reconoce meses escritos : JAN < DEC, ..
Pero los dos mas importantes son:
- -f ignora las mayusculas
- -d modo dicionario, ignora las puntuaciones ¿?,.
- -r cambia de mayor a menor a menor a mayor
- -o {archivo} : guarda los resultados en un fichero aunque sabemos hacerlo sin esto
- -u: agrupa los duplicados en unicos.

*Por ejemplo: agrupar las palabras de un texto y ordenarlas de la z a la a:*
```shell
cat archivo.txt | tr " " "\n" | sort -fdru
```

Si la parte de unificar las palabras en iguales no funciona como esperas con sort -u, puedes utilizar uniq que otorga cierto grado de configuracion:
- -c cuenta el numero de ocurrencia
- -d solo printea las que tienen duplicadas
- -D imprime todas las lineas duplicadas
- -i ignora mayusculas
- -s {int} permite saltarse los primeros n caracteres y ordenar en base a mas adelante
- -w {int} comparar solo n caracteres

*El ejemplo de antes pero con el numero de coincidencias y sin las palabras que solo aparecen una vez:*
```shell
cat archivo.txt | tr " " "\n" | sort -fdr | uniq -cid
```

Ahora imaginate que no te interesan nada mas que las letras de enmedio del abecedario. Podrias crear un filtro con awk o grep de forma sencilla si quisieras hacerlo en un subconjunto especifico de letras. Pero si simplemente estas buscando y buscas agilidad tanta utildad es overkill.
Una solucion sencilla para cuando te sobra output, ya sea por el principio son head y tail que funcionan de forma muy similar:
- -c: para numero de caracteres que imprimir
- -n:  para numero de lineas
Como intuiras por el nombre, head imprime los n caracteres o lineas que le digas y tail hace lo mismo pero por el final. 

Como podriamos quitarle unas pocas lineas a el output que tenemos y quedarnos con el centro?
Vamos a usar wc para saber cuantas lineas hay:
(con -l cuenta las lineas con -m chars con -c bytes y con -w palabras)

*Como ver numero de lineas:*
```shell
cat archivo.txt | tr " " "\n" | sort -fdr | uniq -cid | wc -l
```
*Ahora podrias hacer algo asi por ejemplo:*
```shell
cat archivo.txt | tr " " "\n" | sort -fdr | uniq -cid | head -n 50 | tail
```
*Depende un poco del tamaño de tu fichero pero por ejemplificar*

### Como trabajan entre ellos

Hay ciertas mecanicas que ayudan mucho con este tipo de cosas por ejemplo:

*Pasar un ls como lista de archivos en lugar de como string con los nombres:*
```shell
ls | xargs cat
```

En general normalmente intento organizarme asi:
1. Conseguir el output que necesito al 100% 
2. Conseguir un output lo mas limpio posible si el comando tiene opciones
3. Modificar el output con tr sed o awk para poderlo filtrar comodamente si es necesario
4. Filtrar exclusivamente lo que necesito
5. Modificar el output como quiera

Modificar el output como quiera puede depender mucho de la situacion. En terminal tabuladores, espacios, saltos de linea y texto hacen la mayoria de lo que necesito, no tiene mucho misterio.
Para scripts hay que tener en cuenta varias cosas:

El output se guarda en las variables como texto, hay que hacer algo parecido a esto para que se convierta en un array si se quiere manipular en el script como uno:

```bash
output = $(algun comando super tocho | awk '{printf "%s %s %s:", $1, $2, $3}')
IFS=':' read -r -a array_output <<< "$output"
# ahora podrias tratarlo como un array
for linea in "${array_output[@]}"; do
  echo linea
done
```

Eso lo que hace es definir un separador, aqui se ha utilizado ":" y separa output en elementos de array_output segun esos separadores.

Con ese concepto, si modificas el output de tus comandos para seguir alguna jerarquia de separadores con caracteres especiales podrias simular arrays multidimensionales:

```bash
output = $(algun comando super tocho | awk {printf "%s;%s;%s:", $1, $2, $3})
IFS=':' read -r -a array_output <<< "$output"
# ahora podrias tratarlo como un array
for linea in "${array_output[@]}"; do
  IFS=';' read -r -a array_linea <<< "$linea"
  # ahora podrias tratar cada linea como array
  for item in "${array_linea[@]}"; do
    echo item
  done 
done
```

## Conclusion
En general la clave es pensar con que sabes hacer cada cosa, filtrar es facil con grep, sed reemplaza rapido, head y tail enseñan el principio o el final, tr cambia un separador por otro, si se trata de contar se usa wq y de agrupar y ordenar con sort y uniq.
Con awk puedes hacer lo que tu quieras y con find puedes encontrar lo que quieras.

La cantidad de tiempo que te puedes ahorrar cacharreando con todo esto es tremenda, por no hablar de automatizando con script de bash.

Recomiendo buscar logs en tu sistema o crear lore ipsum para cacharrear.

## Reversas - Remotas - Manejo de TTY:

Cuando accedes a conexiones remotas, a menudo hay problemas de imcompatibilidad entre la terminal host y la remota que hacen que la terminal no funcina como esperamos.

Es un trabajo tedioso adaptarlo y depende mucho de la temrinal en la que te encuentres, el servicio, etc.

Sin embargo hay ciertas cosas que se pueden probar.

### Shell del Host:

Mucha gente y muchas distribuciones, sobretodo del mundo de la ciberseguridad, acostumbran a utilziar zsh o incluso entornos customizados de zsh como puede ser la powerlevel10k.

A mi personalmente me encantan y lo recomiendo, pero a la hora de crear conexiones remotas, recomiendo siempre salir de ese entorno mediante *sh*.

De esta forma tendriamos una terminal base de bash basica que muy probablemente sea muy compatible con la terminal remota.

### Shell Remota:

Esto no suele estar en tu mano, puedes utilizar la conexion que tengas o la reversa que hayas conseguido introducir y ejecutar.

Sin embargo al acceder se pueden hacer ciertas cosas para asegurarte de estar dentro de una terminal bash.

Esto suele depender del software que tengas a tu disposicion en la maquina:
```shell
python -c 'import pty; pty.spawn("/bin/bash")' 
script /dev/null -qc /bin/bash
echo os.system('/bin/bash')
/bin/sh -i
perl -e 'exec "/bin/sh";'
# dentro de perl:
exec "/bin/bsh";
# dentro de ruby:
exec "/bin/bsh"
# dentro de lua:
os.execute('/bin/bash')
# dentro de vi
:!bash
# dentro de vi tambien
:set shell=/bin/bash:shell
```

### Adaptar la terminal:

Como hemos visto anteriormente con Ctrl+Z se puede suspender un proceso y dejarlo en espera en segundo plano.
Vamos a hacer esto con la terminal remota.

Una vez suspendida, con *stty raw -echo* puedes poner la salida en crudo, que a menudo funciona mejor con las conexiones remotas.

Si tu terminal esta algo configurada, utilizas algun emulador de terminal en concreto, o cosas por el estilo, incluso aunque te hayas pasado a bash al inicio, es normal que al hacer esto se rompan agunas cosas. Por ejemplo: no ver lo que escribes, indentacion extraña, saltos de linea extraños.

Pero no preocuparse por esto, el siguiente comando es *fg*, como hemos visto antes, esto traera el proceso suspendido a primer plano, asique, lo veamos bien o no, deberiamos estar en la reversa.

Recomiendo darle al enter un par de veces y hacer Ctr+L.

Ya tenemos bastante nivel de interactividad en la mayoria de casos.

Aun asi para asegurarse yo haria:
```shell
export SHELL=/bin/bash
export TERM=screen
stty rows 38 columns 116
reset
```

## Practica - Herramienta Enumeracion (arp-scan + nmap)

Para practicar podrias lanzar un arp-scan desde un script, filtrar su salida para mostrar un menu con IPs disponibles y que selecionando por terminal les lance un nmap.

