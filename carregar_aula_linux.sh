#!/bin/sh

echo "*************************************"
echo "* Sistema de Carregamento de Codigo *"
echo "*         by: Daniel Ciolfi         *"
echo "*************************************"
echo "*"

export id=1
read -p "* Selecione o numero da aula: " id

export areyousure="N"
read -p "* Deseja realmente deletar a pasta lib e baixar o codigo da aula $id (S/[N])?" areyousure

case $areyousure in
    [Nn]* ) exit;;
    [Ss]* )
        echo "* Removendo a pasta lib"
        rm -rf lib

        echo "* Buscando o codigo da aula $id"

        git clone https://github.com/Dhciolfi/xlo-lib.git lib
        if [ $? -ne 0 ]; then
            echo "* Nao foi possivel carregar a aula do GitHub"
            exit
        fi

        cd lib
        git checkout $id

        if [ $? -ne 0 ]; then
            echo "* Selecione uma aula valida"
            cd ..
            rm -rf lib
            exit
        fi

        echo "* Codigo da aula $id carregado com sucesso!"
        cd ..
    ;;
    * ) exit;;
esac