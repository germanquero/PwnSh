# Reverse Shell Interactivas (TTYs completas)
#### PwnSh: Sesión 2.0

-----

## Indice
- [Reverse Shell Interactivas (TTYs completas)](#reverse-shell-interactivas-ttys-completas)
      - [PwnSh: Sesion 2.0](#pwnsh-sesion-20)
  - [Introducción](#introduccion)
  - [Proceso](#proceso)
    - [Shell del Host](#shell-del-host)
    - [Shell Remota:](#shell-remota)
    - [Adaptar la terminal:](#adaptar-la-terminal)
  - [Conclusion](#conclusion)

## Introducción 
Cuando accedes a conexiones remotas, a menudo hay problemas de incompatibilidad entre la terminal host y la remota que hacen que la terminal no funcina como esperamos.

Esto se debe a que a menudo se envía el input y el output por la conexión pasando por un fichero,  no tenemos un emulador de terminal por encima que reconozca los tabuladores, flechas, escapes, clear (comandos que limpian la terminal), ....

Esto puede dar lugar a problemas como no poder hacer Ctrl+C (matar proceso corriendo, en una reversa saldría de la conexión), Ctrl+Z(suspender el proceso corriendo, igual que antes ¡, suspendería la propia conexión), no poder acceder al historial mediante las flechas o auto-completar con el tabulador.

Pero sin duda lo mas importante es que hay comandos, procesos o aplicaciones de terminal, que requieren de interactividad para mostrar su CLI/GUI o para funcionar correctamente.

Es un trabajo tedioso adaptarlo y depende mucho de la terminal en la que te encuentres, el servicio, etc.

Sin embargo hay ciertas cosas que se pueden probar, que no siempre van a asegurar que logres la interactividad al ser un proceso tan situacional, pero si pueden acercarte mucho a tener una shell interactiva.

Antes de continuar, esto es un proceso que sin duda facilita algunos tipos de trabajo, vulnerabilidades y que nos hace la vida algo mas fácil, sin embargo, dependiendo de lo que estemos tratando de hacer en la terminal, no recomiendo demasiado invertir el tiempo en realizar todo este proceso. Seguramente pierdas tiempo si no necesitas interactividad para nada en concreto (algunos comandos requieren interactividad) o es una backdoor o punto de acceso a un equipo que se vaya a reutilizar a menudo (ahí si recomiendo anotar la configuración favorable a la interactividad).

## Proceso
### Shell del Host
A parte de bash, existen muchos otros tipos de sell como zsh, ksh o csh, y tambien muchos emuladores de terminal. Esto hace que sea tarea complicada a veces para nuestra terminal, recibir un output y manejar un input de forma tan cruda como lo hacen ciertas reversas.

A mi personalmente, sobretodo zsh+powerlevel10k, me encanta tener una shell customizada y lo recomiendo, pero a la hora de crear conexiones remotas, recomiendo siempre salir de ese entorno.

Dependiendo de la terminal, tanto remota como local, he encontrado que a veces funciona mejor con bash y otras mejor con sh (una instancia de bash con modo de compatibilidad a una versión anterior)
Esto se arranca en terminal mediante:
```shell
bash
/bin/bash
sh
/bin/sh
```

De esta forma tendríamos una terminal base de bash básica que probablemente sea más compatible con la terminal remota.

### Shell Remota
Esto no suele estar en tu mano, puedes utilizar la conexión que tengas o la reversa que hayas conseguido introducir y ejecutar.

Sin embargo al acceder se pueden hacer ciertas cosas para asegurarte de estar dentro de una terminal bash.

Esto suele depender del software que tengas a tu disposición en la maquina:
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

### Adaptar la terminal
Como hemos vimos en las sesiones de unix-shell con Ctrl+Z se puede suspender un proceso y dejarlo en espera en segundo plano.
Vamos a hacer esto con la terminal remota.

Antes de nada, deberías mirar cierta información sobre la terminal mediante:
```shell
echo $TERM
stty -a | awk -F ';' 'NR==1 {print $2 $3}
```

Esta información va a ser necesaria después cuando volvamos a la terminal remota.

Una vez obtenida dicha información, con *stty raw -echo* puedes poner la salida en crudo, que a menudo funciona mejor con las conexiones remotas.

Si tu terminal esta algo configurada, utilizas algún emulador de terminal en concreto, o cosas por el estilo, incluso aunque te hayas pasado a bash al inicio, es normal que al hacer esto se rompan algunas cosas. *Por ejemplo: no ver lo que escribes, indentación extraña, saltos de linea extraños.*

En este punto lo mejor es ignorar los posibles fallos de entrada/salida y pasar al siguiente comando: *fg*.

Como vimos también en las sesiones de unix-shell, esto traerá el proceso suspendido a primer plano, así que, lo veamos bien o no, deberíamos estar en la reversa.

Recomiendo darle al enter un par de veces y hacer Ctr+L para que se coordine el input y el output con el de tu terminal y puedas ver lo que escribes.

Ya tenemos bastante nivel de interactividad en la mayoría de casos. Aun así para asegurarse yo haría:
```shell
export SHELL=/bin/bash
export TERM=term
stty rows X columns Y
reset
```
Siendo term, x e y la información obtenida antes en tu terminal.

## Conclusion
Mejorar una shell sencilla remota a una tty completamente interactiva puede ser tan útil como gastoso en tiempo, por eso hay que ser inteligentes con cuando queremos o necesitamos realizar todo este proceso.

Es muy útil conocer estas estrategias, no para realizar este proceso en cada reversa que obtengamos, si no para aumentar nuestra bolsa de recursos que puedan ayudarnos.

Prácticamente cualquier persona que haya obtenido mas de 3 reversas en su vida conoce el truco de python y pty y lo útil que puede llegar a ser cuando la shell es muy inestable. Conocer todos estos trucos nos hacen mucho más resilientes ante cualquier terminal, por muy inestable que sea.

Espero que hayas podido aprender algo sobre la interactividad de la terminal.

No dudes en hacer pull-request con cualquier cosa que te gustaría ver corregida.

Un saludo.

