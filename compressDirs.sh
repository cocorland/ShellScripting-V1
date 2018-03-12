#!/bin/bash
#################################################################
#			                 	  	    	#
#	Script que recorre todos los directorios y deja un	#
#	archivo tar.gz en cada en cada directorio que con-	#
#	tenga solo los archivos de ese directorio.		#
#                                                               #
#################################################################
#	Creado por: Orlando Chaparro S. 
#	Carnet: 	12-11499

function revisoRecursivo()
{
	for j in *	#Reviso cada uno de los elementos en el directorio actual
	do
		if [ -d $j ]	#Si un elemento es un directorio, entra en el condicional
		then		
			cd $j		          #Entro en el directorio que acabo de descubrir
			revisoRecursivo		#Reviso de nuevo todos los elementos del nuevo directorio
			cd ..
		elif [ -f $j ]	#Si un elemento es un archivo, entra en el condicional
		then
			A=`pwd`		#Variable para poderle dar el nombre de la ruta al nuevo .tar.gz
			test ! -e "temporal" && mkdir "temporal"	#Creamos la carpeta donde se respalda todo el contenido
			if [ -d "temporal" ]
			then
				#Inicio del for que guarda todos los archivos (Exceptuando directorios) en una carpeta temporal
				for i in `ls -gnoc $1 | grep '^-'`	#Se listan todos los archivos, si no son directorios, se copian a la carpeta temporal
				do
					if [ -e $i ]
					then
						cp $i "temporal"
					fi
				done
				#Fin del ciclo for
			fi
			#Inicio de la parte del programa que comprime las carpetas temporales
			tar -zcvf $A.tar.gz temporal
			rm -r temporal
			#Fin de la compresion. Se eliminan carpetas temporales
		fi
	done
}

#Se invoca a la funcion
revisoRecursivo
