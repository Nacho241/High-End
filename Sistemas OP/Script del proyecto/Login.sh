#!/bin/bash

#Seccion dedicada a control el ingreso de el argumento "--help"
for i in $*
do
    if [ "$i" == "--help" ]
    then
        cat ./Recursos/Ayuda
        exit
    fi

done

touch ./Recursos/usuarios.txt
opc=0
while [ "$opc" != "2" ]; do
        clear
        echo "1) Ingresar"
        echo "2) Salir"
        read -p "¿Que opcion quiere seleccionar?:" opc

        case $opc in

        1)
                read -p "Ingrese su cedula a continuacion: " cedula
                if [ ${#cedula} -ne 8 ]
                then
                    echo "Cedula ingresada Incorrecta o nula"
                    sleep 1
                else
                    echo ""
                    read -sp "Ingrese su contraseña: " contrasena
                    if [ -z "$contrasena" ]
                    then
                        echo "el campo de contraseña esta vacio"
                        sleep 1
                    else
                        echo ""
                        cedulaUsuarioIngresado=$(cut -d":" -f1 ./Recursos/usuarios.txt | grep -w $cedula)
                        contrasenaUsuarioIngresado=$(cut -d":" -f2 ./Recursos/usuarios.txt | grep -w $contrasena)
                        if [ -z "$cedulaUsuarioIngresado" ] && [ -z "$contrasenaUsuarioIngresado" ]
                        then
                                echo "El usuario no existe."
                                sleep 1
                        else
                                echo "Sesion ingresada correctamente."
                                rangoUsuarioIngresado=$(grep $cedulaUsuarioIngresado ./Recursos/usuarios.txt | cut -d":" -f5)
                                
                                if [ "$rangoUsuarioIngresado" = "Administrador" ]
                                then
                                        ./Menus/menuAdministrador.sh
                                else
                                        if [ "$rangoUsuarioIngresado" = "Ingeniero" ] 
                                        then
                                        ./Menus/menuIngeniero.sh
                                        else        
                                                if [ "$rangoUsuarioIngresado" = "Consultas" ]
                                                then
                                                        ./Menus/menuConsultas.sh
                                                fi
                                        fi
                                fi
                        fi
                    fi
                fi
                ;;
        
        2)
                echo
                echo "¡Adios!"
        ;;

        *)
                echo "Ingresó una opcion incorrecta, vuelva a intentarlo."
                echo
                sleep 1
        ;;
        esac
done