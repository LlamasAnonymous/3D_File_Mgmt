$files = ls "$home\OneDrive\3Dobjects"

foreach ($file in $files) {
    mkdir "$file\pla\gcode"
    mkdir "$file\pla\3mf"
    
    mkdir "$file\petg\gcode"
    mkdir "$file\petg\3mf"
    
    mkdir "$file\abs\gcode"
    mkdir "$file\abs\3mf"

    mkdir "$file\tpu\gcode"
    mkdir "$file\tpu\3mf"

    mkdir "$file\blend\Printable"
    mkdir "$file\notes"
    mkdir "$file\pics"
    mkdir "$file\stl"

    Move-Item "$file\pla\*.3mf" "$file\pla\3mf"
    Move-Item "$file\pla\*.gcode" "$file\pla\gcode"
}

$files = ls "$home\OneDrive\3Dobjects\Contraband"

foreach ($file in $files) {
    mkdir "$file\pla\gcode"
    mkdir "$file\pla\3mf"
    
    mkdir "$file\petg\gcode"
    mkdir "$file\petg\3mf"
    
    mkdir "$file\abs\gcode"
    mkdir "$file\abs\3mf"

    mkdir "$file\tpu\gcode"
    mkdir "$file\tpu\3mf"

    mkdir "$file\blend\Printable"
    mkdir "$file\notes"
    mkdir "$file\pics"
    mkdir "$file\stl"

    Move-Item "$file\pla\*.3mf" "$file\pla\3mf"
    Move-Item "$file\pla\*.gcode" "$file\pla\gcode"
}