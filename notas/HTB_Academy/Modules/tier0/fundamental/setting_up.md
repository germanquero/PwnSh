# Modulo: Setting Up
## HTB Academy - Tier0 - Fundamental
---

Dependiendo de la empresa que nos contrate, tendremos que actuar desde una maquina interna, conectandonos a un host interno por ssh o con nuestra maquina si nuestro cliente no quiere hostear ninguna imagen o administrarnos una conexion VPN.


Cuando trabajamos con un host interno del cliente es importante disponer de un VPS (Virtual Private Server) donde acceder a nuestras herramientas.

Cuando se trabaja remotamente, normalmente se envia un dispositivo con nuestro OS de elecion para atacar que se conecte via VPN a nuestra infraestructura.

El cliente es quien elije si darnos acceso ssh añadiendo nuestra IP a la lista blanca o si nos da acceso VPN directamente a su red. 

Sea cual sea la situacion es importante disponer de forma previa antes de cualquier test de penetracion o ejercicio de red team, una maquina linux y otra windows con todas las herramientas configuradas y funcionando de forma previa a comenzar el ejercicio.


La eficiencia y el conocimiento de nuestros propios sistemas y herraminetas de ataque define una gran parte de nuestra eficacia y eficiencia en el trabajo como pentesters o red teamers.


Tambiene esta recomendado crearte un arbol de directorios que te mantenga ordenado durante el ejercicio y plantillas de documentacion.

En mi caso me he creado aliases y scripts que automatizan la tarea, y por animo de mantenerlo flexible creo lo siguiente:

Ejemplo
├── 0recon
├── 1acces
├── 2lateral
├── 3explt
├── 4post
└── Reporte_Ejemplo.tex

Una carpeta para cada seccion de un ataque: Reconocimiento, (Vectores de) Acceso, (Movimiento) Lateral (y Escalado de privilegios), Explotacion y Postexplotacion.

Esto es util para guardar capturas, informacion o redirigir la salida de ciertos comandos a archivos dentro de estos directorios.
Recomiendo seguir profundizando el arbol si es necesario. Por ejemplo si te encuentras una red con muchos equipos no mandes todo el reconocimiento de todos los equipos a 0recon, crea carpetas y mantenlo organizado.

De cara a la documentacion de primeras basta con crearse un fichero con las mismas secciones definidas que las que hemos mencionado con los directorios. Con el timpo segun te especialices o aprendas la metodologia o forma de trabajar que te funciona, puedes seccionar mas el fichero o añadir textos preescritos o incluso todolist que te guien sobre que deberias ir probando.

Para documentar yo utilizo latex porque me parece mas rapido que los drag and drops y las selecciones tipicas de los editores de docx.

Lo importante es que sea detallado, profesional y tratar de mantener un orden y adelantar trabajo de documentacion durante el proceso de testeo para evitar tener que volver para atras a documentar.

Este apartado tambien habla de como un PasswordManager puede ahorrarte mucho tiempo y memoria de recordar las distintas credenciales que un usuario puede reutilizar en muchos sitios o las credenciales default.

Esto esta bien pero debido a ciertos fallos de seguridad (Leaks) que han tenido recientemente algunas de estas empresas, prefiero acostumbrarme a no utilizar ninguno y documentar a mano las credenciales de forma segura y encirptada en el mismo equipo con el que realizo las pruebas para evitar que cualquier credencial (por mas vulnerada o reusada que este) de nuestro cliente, nunca salga de nuestro equipo para mantenerlo mas profesional y mas seguro para ellos (y mas fiel a un posible NDA)

Luego habla de la automitizacion, que refiere a cosasas como las que he mencionado antes, crearte scripts que te creeen arboles de directorios, repos en githubs con scripts utiles para ciertos caso, ect, ect. Es importante como pentester no requerir de horas de trabajo manual para cualquier parte del proceso. Si se puede automatizar de forma estable y que te ahorre tiempo de verdad, hazlo.

Tambien menciona sobre la importancia de tomar notas, mientras estudias, como es logico, y tambien mientras vulneras a tus clientes. Posbles descubrimientos, caracteristicas de la empresa, y cosas de ese estilo es importante tenerlas anotadas.

No solo por documentar como hablabamos antes. Es una parte crucial en el desarollo de un hacker/pentester/redteamer ir aumentando nuestra base de datos (mental y en forma de notas) de casos, vulnerabilidades, estructuras, organizaciones, etc, etc. Recomienda utilizar cosas tipo Notion u Obsidian. En mi caso me gusta mucho neovim y como mencione antes, me preocupo bastante por lo que subo a servidores aleatorios.

He encontrado que me manejo bien utilizando Latex para documentar, Markdown para tomar notas rapidas, GitHub para compartir notas o realizar copias de seguridad de ellas y NeoVim como editor de texto (si no quieres ponerte a estudiar Vim, aunque no es tan dificil, recomiendo VSCode o Code-OSS, lo mismo pero open source)


Tambien habla de herraminetas como PwnDoc o GhostWriter que te ayudan a guardar logs y crear la Documentacion de forma mas sencilla. Como digo yo no soy fan de estas cosas y me manejo muy bien con la terminal y ficheros de texto, pero la verdad que parecen un sistema organizado y sencillo, recomiendo echarles un ojo y decidir por vuestra cuenta.

Logear todo lo que hacemos no es solo importante para documentar si no tambien para nuestra proteccion. Si ocurre un ataque de verdad durante nuestro ejercicio hay que saber defender y explicar que los daños no han sido a causa de nuestro trabajo.

Para screenshots recomienda Flameshot y Peek. No soy muy fan de los gif y suelo documentar en pdf. Me gusta la opcion de que el reporte no solo sea digital (si argumentas todo con gif y el cliente lo imprime se pierde la mitad de lo que querias contarle). Por ese motivo Peek no me entusiasma. Flameshot tiene mucha capacidad de editar las capturas antes de guardaras y alguna cosa mas.

En mi caso, las capturas de pantalla no me parecen algo tan prioritario, hacerlas si, de cara al software y sus capacidades, prefiero lo mas simple posible. Me he configurado con sxhkd la tecla print para permitirme selecionar un cacho de pantalla y guardarlo en cierto directorio. A parte lo he configurado para dejarme el path de la captura en el portapapeles para que me sea sencillo moverlo con rapidez a donde lo requiera. Nuevamente, mi forma de trabajar, explora las opciones y busca que funciona contigo.


Despues este modulo habla sobre la virtualizacion y sus multiples aspectos asi como ventajas principales:
- Se pueden clonar mover y restaurar con extrema facilidad
- No interfieren con la maquina host
- Se le pueden asignar recursos hardware dinamicamente (espacio, ram, interfaces de red, etc)
- Habilidad para crear entornos aislados completamnete virtualizados sobre los que trabajar
- ...

En resumen, para avanzar en esto del pentesting y para trabajar comodamente hay que acostumbrarse a levantar maquinas virtuales y configurarlas velozmente, tener OVAs(el tipo de fichero para guardar maquinas virtuales) preconfiguradas y un buen laboratorio con una red interna que manipular para practicar.

HTB y yo recomendamos VMware porque otorga mejores resultados de optimizacion para mi gusto. Si no quieres buscar una key por ahi o pagar,lo cual seria normal, VirtualBox es un buen hipervisor gratuito.

En el modulo te explica como instalar VMware pero no tiene mucho misteri la verdad.


Lo siguiente de lo que habla son los contenedores. No son exacamente VMs aunque se parecen un poco. SOn grupos aislados de procesos corriendo en un solo host. No contiene ni SO ni kernel por tanto no se puede considerar una maquina independiente como una VM, sin embargo son mucho mas reutilizables. A veces se refiere a los contenedores como Virtualizacion de Aplicaciones.

Mientras que las VMs corren en un hipervisor que les otorga la virtualizacion dentro de un mismo host, los contenedores corren dentro de un mismo sistema operativo gracias al motor de contenedores y solo contienen las partes del SO necesarias para completar su trabajo.


Despues te habla de docker, que es basicamente el sistema de contenedores open source mas conocido y utilizado. Esto se debe a que con docker un mismo contenedor puede funcionar en practicamente cualquier SO y gracias a un HiperVisor, en cualquier equipo, claro.

Tambien recomienda vagrant que parece un sistema de virtualizacion + contenedores, nunca lo he usado y no lo conocia hasta ahora. Lo mirare mas en profundidad.

Ahora habla de las distribuciones Linux de pentesting, Parrot, Kali, Blackbox y BlackArch. Gracias a blackarch y sus repos, yo estoy utilizando un arch nativo con sus repos configurados en pacman, de forma que me voy instalando las herramientas que me gustan y necesito en lugar de tener tantisimas preinstaladas como es el caso de esas distribuiciones. De esas solo tengo experiencia con Kali, la verdad que va genial y tiene una gran variedad de herramientas muy utiles sobretodo cuando estas aun aprendiendo los basicos para no tener que lidiar con instalaciones y configuraciones. (eso si, no hagas sudo apt upgrade en cualquiera de esas, nunca)

HTB recomienda parrot, es la que te dejan dentro de su plataforma y la que te enseñan a instalar en este modulo.

Tambien recomienda TMUX y alguna herramienta mas, el sistema operativo montatelo como quieras y te resulte mejor trabajar.

En mi caso es:
Arch Linux + Bspwm + Polybar + gnome-terminal (zsh powerlevel10k) + NeoVim (sin distro)


Es una forma un poco manual pero muy configurable de tener un equipo bastante funcional.
Si te gustan los window manager tipo bspwm o i3 que son tileables hay mucha gente que ha hecho scripts en github para confiruar parrotOS con bspwm de manera similar a lo que utiliza s4vitar (youtuber canario muy reconocido en la comunidad).

Como hemos hablado antes tambien es recomentable tener una VM de windows. HTB recomienda descargarse una VM preconfigurada para desarollo del sitio web oficiañ de Microsoft, instalarle un WSL(Windows Subsystem for Linux) y el gesto de paquetes Chocolatey y configurar defender para que no nos elimine o ponga en cuarentena herramientas que nos podamos instalar.

Como con todo recomiendo hacer snapshots en tu hipervisor de forma bastante continuada cada vez que configures algo significativo.

Las VPS (Virtual Private Server) son parte de las soluciones de IaaS(Infraestructure As A Service), basicamente son un entorno aislado virtualizado dentro de un servidor fisico. Ofrece las mismas soluciones que un servidor completo, con sus recursos reservados a peticion, y completa libertad de configuracion a un precio mas asequible que un servidor dedicado. Por su similitud a menudo se refieren a las VPS como VDS (Virtual Dedicated Server).

Las VPS se utilizan mucho para: VPN, Servidores C2, Repositorios, Pentesting, Desarollo y Testeo, Servidores Proxy, Servidores DNS, Servidores Web (LAMP, XAMPP, MERN), Mail y videojuegos.

La siguiente seccion trata de como configurar una VPS con un provider llamado Vultr y como generar claves ssk para ello. Este proceso lo concia y no queria invertir en una VPS ahora mismo. Recomiendo hacerlo si nunca has configurado una, pero es algo que se puede dejar para mas adelante si no lo necesitas ahora mismo.

Esto viene continuado de como mejorar la seguridad de un VPS. Esto se debe a que las VPS estan configuradas para acceptar bastante trafico y tipos de servicios, entonces es parte de nuestra labor minimizar los posibles vectores de acceso al VPS. Recomienda las siguientes precauciones:
- Instalar Fail2ban
- Trabajar solo con claves ssh
- Reducir el tiempo de idle
- No permitir cnontraseñas
- No permitir x11 port fordwarding
- Usar un puerto distinto
- Limitar el acceso SSH a usuarios
- No permitir logins como root
- Usar ssh proto 2
- Configurar 2FA para ssh

Se recomienda crearte una VM y probar todo esto antes de realizarlo en la VPS para asegurarte de su correcto funcionamiento de forma previa.
En la seccion hay una version mas detallada del proceso de configurar todo esto.

Para configurar el 2FA HTB recomienda utilizar el PAM(Pluggable Authentication Modules) de Google.


Y con esto se termina este modulo.
