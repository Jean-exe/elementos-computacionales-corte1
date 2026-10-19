#!/bin/bash
#1.Definimos el argumento
Carpeta=$1
# si no se da argumento da error
if [ -z "$Carpeta" ]; then
echo "Error: Deber poner un argumento"
echo "Uso del script: $0 ruta/al/directorio"
exit 1
fi
# Aqui miramos si la carpeta existe o no
if [ ! -d "$Carpeta" ]; then
echo "Error: El directorio '$Carpeta' no existe"
exit 1
fi
# Esto nos dice cuantos archivos.txt contiene
shopt -s nullglob
arc_txt=("$Carpeta"/*.txt)
Contador=${#arc_txt[@]}
#creamos una subcarpeta
Fechayhora=$(date +%y-%m-%d)
Comodin="$Carpeta/backup_$Fechayhora"
mkdir -p "$Comodin"
#Copia los archivos y les cambia el nombre
Log_file="$Comodin/resumen.log"
echo "=== Resumen - $Fechayhora===" > "$Log_file"
echo "Archivos .txt encontrados: $Contador" >> "$Log_file"
echo "Archivos copiados:" >> "$Log_file"
#Si se encontraron archivos.txt, los copia con un nuevo nombre
#luego los manda a la otra carpeta
if [ $Contador -gt 0 ]; then
for i in "${arc_txt[@]}"; do
Nombre=$(basename "$i")
Nuevo_nombre="${Fechayhora}_${Nombre}"
cp "$i" "$Comodin/$Nuevo_nombre"
echo "- $Nombre -> $Nuevo_nombre" >> "$Log_file"
done
#En caso de no encontrar archivos.txt no se se realiza ninguna copia
else
echo "No hay archivos.txt" >> "$Log_file"
fi
echo "Copia guardada en $Comodin"




