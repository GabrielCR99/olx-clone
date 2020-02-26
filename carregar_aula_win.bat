@echo off

echo *************************************
echo * Sistema de Carregamento de Codigo *
echo *         by: Daniel Ciolfi         *
echo *************************************
echo *

set id=1
set /p id="* Selecione o numero da aula: "

set areyousure="N"
set /p areyousure=* Deseja realmente deletar a pasta lib e baixar o codigo da aula %id% (S/[N])?
if /I "%areyousure%" neq "S" goto END

echo * Removendo a pasta lib
rmdir lib /Q /S

echo * Buscando o codigo da aula %id%

git clone https://github.com/Dhciolfi/xlo-lib.git lib
IF %ERRORLEVEL% NEQ 0 (
  echo * Nao foi possivel carregar a aula do GitHub
  goto END
)

cd lib
git checkout %id%

IF %ERRORLEVEL% NEQ 0 (
  echo * Selecione uma aula valida
  cd ..
  rmdir lib /Q /S
  goto END
)

echo * Codigo da aula %id% carregado com sucesso!
cd ..

:END
pause