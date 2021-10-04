# VBScript-Reverse-connection

Sencillo Script en visual basic scripting para ejecutar comandos locales por medio de un C&C muy basico.

Por el lado del Script del cliente debe ejecutarse el archivo vbs_reverse_client.vbs, debe reemplazarse en la parte de la variable url el valor "x.x.x.x" por la IP real del servidor.

Por el lado del servidor debe habilitarse el servidor Web para que sea capaz de ejecutar archivos Python .py y se debe crear un archivo llamado entradacomando.txt y copiar el archivo vbs_reverse_server.py

En el archivo entradacomando.txt  es donde se escribe el comando que se quiere que el cliente ejecute, por ejemplo "ipconfig /all" 

El cliente consultara via un HTTP GET periodicamente al servidor y si encuentra un comando lo ejecuta y envia la respuesta de vuelta al servidor mediante un HTTP POST.

Desde el servidor existen 3 comandos especiales:

1.- "SALIR"   el cual termina la ejecucion del script en el cliente.

2.- "DETENER" el cual mantiene las consultas GET pero no ejecuta comandos en el cliente y tampoco envia nada de vuelta.

3.- "PHISHING"  el cual muestra un prompt de Windows al usuario para que ingrese sus crendenciales y al hacerlo enviar estas por HTTP POST al servidor.

Toda la info enviada por el cliente al servidor es escrita por el servidor en un archivo llamado salidacomando.txt, por lo cual el servidor Web debe tener permisos de escritura al directorio donde copiara ese archivo.
