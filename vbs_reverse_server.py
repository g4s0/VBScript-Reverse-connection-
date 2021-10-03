#!/usr/bin/env python

import os
import cgitb, cgi
cgitb.enable()

def read_command():
    try:
        with open("entradacomando.txt", "r") as f:                  
            command=f.read()
    except:
        command="Error en la lectura del comando"        
    return command   

def write_command():
    formu = cgi.FieldStorage()
    command=formu.getvalue('commandresult')
    info=formu.getvalue('inforesult')
    result="\n\n"+info+"\n\n\n"+command+"\n\n"
    try:  
        with open("salidacomando.txt", "w") as f1:                  
            f1.write(result)
        result="OK"
    except:
        result="Error en la escritura del comando"        
    return result                   

if os.environ['REQUEST_METHOD'] == 'GET':
    try:
        body=read_command()
    except:
        body="Error en la lectura del comando"
               
if os.environ['REQUEST_METHOD'] == 'POST':
    try:
        body=write_command()
    except:
        body="Error en la escritura del comando"
           
print "Content-Type: text/html"
print
body=body.encode('ascii','ignore')

print body
