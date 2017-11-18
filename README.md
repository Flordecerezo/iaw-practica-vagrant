# iaw-practica-vagrant

>IES Celia Viñas (Almería) - Curso 2017/2018  
>Módulo: IAW - Implantación de Aplicaciones Web  
>Ciclo: CFGS Administración de Sistemas Informáticos en Red  

Colección de ejemplos de configuraciones para [Vagrant][1].

## Ejemplos

1. Configuración para una máquina virtual con [Ubuntu 16.04.3 LTS (Xenial Xerus)][2].
2. Configuración para compartir un directorio entre el host anfitrión y la máquina virtual.
3. Configuración para crear una máquina virtual con [Apache HTTP Server][3], IP estática y directorio compartido.
4. Configuración para dos máquinas virtuales: [Apache HTTP Server][3] y [MySQL Server][4], con aprovisionamiento vía shell.
5. Configuración para una infraestructura para [WordPress][5] formada por un balanceador de carga, dos frontales web con [Apache HTTP Server][3] y un *back-end* con [MySQL Server][4], con aprovisionamiento vía shell.


[1]: https://www.vagrantup.com
[2]: https://app.vagrantup.com/ubuntu/boxes/xenial64
[3]: https://httpd.apache.org
[4]: https://dev.mysql.com/downloads/mysql/
[5]: https://wordpress.org