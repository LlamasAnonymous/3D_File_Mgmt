$ErrorActionPreference = 'SilentlyContinue'
cls

function filereplacement {
	if ($) {

	}
}


# Gets and edits the file path that is entered
function filepath {

	# First ask
	$filepath = Read-Host

	$filepath = $filepath.Replace('"', '')

	# Error checking
	While ((Test-Path $filepath) -eq $false) {

		cls
		'Error:'
		Start-Sleep 1
		"Could not find a file path for: $filepath"
		Start-Sleep 1
		# This variable changes depending what the original question was
		$example
		$filepath = Read-Host

		$filepath = $filepath.Replace('"', '')
	}

	# Allows you to use the $filepath variable outside of the function
	$Global:filepath = $filepath

	cls
}


# Creates the folders (Gets info from config files and inputs)
function directory {

	mkdir "$basefolder\$filename"

	# Gets all of the printers described in the printers config file, and creates a folder for each one
	foreach ($printer in $printerextracted) {

		mkdir "$basefolder\$filename\$printer"
	}

	# Nests each material name in the materials config file inside of each printer folder
	foreach ($materialname in $materialsextracted) {

		mkdir "$basefolder\$filename\$printer\$materialname"
	}

	$cat = "blend\Printable", "pics", "stl", "notes"

	foreach ($folder in $cat) {

		mkdir "$basefolder\$filename\$folder"
	}
	
	New-Item "$basefolder\$filename\notes\Notes.txt"
	# Opens the modeling software if that option was enabled
	Start-Process $modelinglocationstring
}


# Pulls all of the files based on their extension, and organizes them into the newely created folders
function organization {

	Get-ChildItem "$basefolder\$filename\$selectedname" -Recurse  | Where-Object { $_.Extension -eq ".stl" } | foreach-object { Move-Item $_ "$basefolder\$filename\stl" }
	Get-ChildItem "$basefolder\$filename\$selectedname" -Recurse | Where-Object { $_.Extension -eq ".jpg", ".jpeg", ".png" } | foreach-object { Move-Item $_ "$basefolder\$filename\pics" }
	Get-ChildItem "$basefolder\$filename\$selectedname" -Recurse | Where-Object { $_.Extension -eq ".3mf", ".gcode" } | foreach-object { Move-Item $_ "$basefolder\$filename" }
	Get-ChildItem "$basefolder\$filename\$selectedname" -Recurse | Where-Object { $_.Extension -eq ".txt", ".pdf" } | foreach-object { Move-Item $_ "$basefolder\$filename\notes" }
	start $basefolder\$filename

	"Moved the file: $zippeddir"
	"To: $basefolder\$filename"
	Read-Host "Hit enter:"
}


$printerconf = "$home\New3Dconfig\Printers.txt"
$materialconf = "$home\New3Dconfig\Materials.txt"
$scratchconf = "$home\New3Dconfig\ScratchConfig.txt"
$somewhereconf = "$home\New3Dconfig\SomewhereConfig.txt"
$modelingsoftware = "$home\New3Dconfig\ModelingSoftwareLocation.txt"


$printerextracted = Get-Content $printerconf
$materialsextracted = Get-Content $materialconf
$fromscratchextracted = Get-Content $scratchconf
$somewhereextracted = Get-Content $somewhereconf
$modelinglocation = Get-Content $modelingsoftware
$blenderanswerex = $modelinglocation[1]

$testpathextracted = $fromscratchextracted, $somewhereextracted, $printerconf, $materialconf

$a = 0

while ($locationcheck -eq "check_failed" -or $a -lt 1) {

	if ((Test-Path $testpathextracted) -and $locationcheck -ne "check_failed") {

		'Do you want to reset any configuration settings? (y,n)'
		$conf = Read-Host

		cls

		while (1) {

			cls

			$confarray = "Printer", "material", "file location", "modeling software auto-open preference"

			if ($conf -eq "y") {

				'What would you like to edit?'
				''
				'[0]: Printer names'
				'[1]: Materials'
				'[2]: File locations'
				'[3]: Modeling software auto-open preference'
				'[4]: All'
				''
				'Choose an option based on the number in the brackets'
				$confanswer = Read-Host "You want to change option"

				cls

				while ($confanswer -notin 0..4) {

					'Please choose one of the options.'
					''
					'	[0]: Printer names'
					'	[1]: Materials'
					'	[2]: File locations'
					'	[3]: Modeling software auto-open preference'
					'	[4]: All'
					''
					$confanswer = Read-Host "You want to change option"

					cls
				}

				if ($confanswer -eq 4) {

					'Are you sure that you want to reset ALL configuration settings? (y,n)'
					$selection = Read-Host
				
					if ($selection -eq "y") {
						
						rd "$home\New3Dconfig" -r -Force
						mkdir "$home\New3Dconfig" | Out-Null
						Break
					}
				}
				else {

					"You want to change the " + $confarray[$confanswer] + " configurations? (y,n)"
					$selection = Read-Host

					if ($selection -eq "y") {

						Break
					}
					
				}
			}
			else {

				Break
			}
		}
	}
	else {

		$confanswer = 4
	}


	if ($confanswer -eq "0" -or $confanswer -eq "4") {

		rd $printerconf -Force

		$printernumber = 1
	
		while (1) {

			cls
			$printerextracted = Get-Content $printerconf
			"Previous Printers: $printerextracted"
			"Printer: $printernumber
			"
			'What do you want to name this printer?
			'
			'Whatever you enter in here, will be the name of the folder that you can store all of your sliced files
			'
			'Example: Ender3S1Pro, Bambu_Labs_X1C, BLp1s
			'
			'Just leave the space blank, and hit enter when you are finished
			'
			$printername = Read-Host
			$printername = $printername.Replace(' ', '_')

			if ($printername -eq "") {

				Break
			}
			else {

				if ($printernumber -eq 1) {

					$printername | Out-File $printerconf -Force
				}
				else {

					$printername | Out-File $printerconf -Append	
				}

				$printernumber = $printernumber + 1
			}

		}
	}

	cls

	if ($confanswer -eq "1" -or $confanswer -eq "4") {

		rd $materialconf -Force

		$materialnumber = 1

		while (1) {

			cls
			$materialsextracted = Get-Content $materialconf
			"Previous materials: $materialsextracted"
			"Material: $materialnumber
			"
			'What material will you be printing with?
			'
			'If you enter "basic", it will set the config to the default setup.'
			'i.e. PLA, PLA+, ABS, TPU, PETG
			'
			'Just leave the space blank and hit enter when you are finished.
			'
			$material = Read-Host
			$material = $material.Replace(' ', '_')

			cls

			if ($material -eq "basic") {
					'The default setup has been set.
					'
					'i.e. PLA, PLA+, ABS, TPU, PETG'
				$material = "PLA", "PLA+", "ABS", "TPU", "PETG"
				while (1) {

					"Materials selected: $materialsextracted"
					'Would you like to add anymore? If not just leave it blank and hit enter.
					'
					$material = Read-Host
					$material | Out-File $materialconf
				}
				elseif ($answer -eq "") {
					Break
				}
			}

			if ($material -eq "") {

				Break
			}
			else {

				if ($materialnumber -eq 1) {

					$material | Out-File $materialconf -Force
				}
				else {

					$material | Out-File $materialconf -Append
				}

				$materialnumber = $materialnumber + 1
			}
		}
	}

	cls

	if ($confanswer -eq "2" -or $confanswer -eq "4") {

		'Where would you like to store the file if you are the one that modeled it?'
		'Example: C:\Users\[Your Username]\Documents\3Dfolder\MyCreations'

		$example = '	Where do you want to store the file if you are the one who modeled it?
	Example: C:\Users\[Your Username]\Documents\3Dfolder\MyCreations'
		filepath

		$Global:filepath | Out-File $scratchconf
		

		'Where would you like to store the file if you downloaded it from somewhere?'
		'Example: C:\Users\[Your Username]\Documents\3Dfolder\OthersCreations'

		$example = '	Where would you like to store the file if you downloaded it from somewhere?
	Example: C:\Users\[Your Username]\Documents\3Dfolder\OthersCreations'
		filepath

		$Global:filepath | Out-File $somewhereconf
	}


	if ($confanswer -eq "3" -or $confanswer -eq "4" -or (Test-Path $modelingsoftware) -eq $false) {

		'Would you like to open a 3D modeling software automatically when creating a new file? (y,n)'
		'Example: (Bender, fusion360)'
		$blenderanswer = Read-Host

		cls

		if ($blenderanswer -eq "y") {

			'Where is the 3D modeling software located? Copy the full link, not just the folder that it is nested in.'
			$example = '	Where is the 3D modeling software located? Copy the full link, not just the folder that it is nested in.'
			filepath

			$Global:filepath | Out-File $modelingsoftware -Force
			$blenderanswer | Out-File $modelingsoftware -Append
		}
	}

	$printerextracted = Get-Content $printerconf
	$materialsextracted = Get-Content $materialconf
	$fromscratchextracted = Get-Content $scratchconf
	$somewhereextracted = Get-Content $somewhereconf
	$modelinglocation = Get-Content $modelingsoftware
	$blenderanswerex = $modelinglocation[1]

	$modelinglocationstring = $modelinglocation[0]

	if ($blenderanswerex -ne "y") {
		$modelinglocationstring = "N/A"
	}

	"Do these configurations look right? (y,n)

	Printer name(s): $printerextracted

	Material(s): $materialsextracted
		
	Location if you created the model: $fromscratchextracted
		
	If someone else created the model: $somewhereextracted
		
	3D modeling application location: $modelinglocationstring
	"

	$restart = Read-Host

	if ($restart -eq 'n') {

		$locationcheck = "check_failed"
	}
	else {

		$locationcheck = $null
		cls
	}

	$a = 1
}


$printerextracted = Get-Content $printerconf
$materialsextracted = Get-Content $materialconf
$fromscratchextracted = Get-Content $scratchconf
$somewhereextracted = Get-Content $somewhereconf
$modelinglocation = Get-Content $modelingsoftware

$modelinglocationstring = $modelinglocation[0]


Write-Host "What do you want to name your new 3D object file?"
$filename = Read-Host
$filename = $filename.Replace(" ", "_")

cls

Write-Host "Is this your own creation? (y,n)"
$contraband = Read-Host

cls

while ($contraband -ne "y" -and $contraband -ne "n") {

	Write-Host "Is this your own creation? (y,n)"
	$contraband = Read-Host
	cls
}

if ($contraband -eq "n") {

	while (Test-Path "$somewhereextracted\$filename") {

		"This file name already exists. Pick a new one."
		$filename = Read-Host
		cls
	}
	
	$basefolder = $somewhereextracted
	$zipped = $null

	while ($zipped -eq $null) {

		Write-Host "Do you want to move the file from your Downloads folder? (y,n)"
		$movefromdown = Read-Host

	
		while ($movefromdown -ne "y" -and $movefromdown -ne "n") {

			Write-Host "Do you want to move the file from your Downloads folder? (y,n)"
			$movefromdown = Read-Host
		}

		if ($movefromdown -eq "y") {

			$zipped = Get-ChildItem "$home\Downloads" | Select-Object -Property DirectoryName, BaseName, Extension, LastWriteTime | Sort-Object -Property Extension, LastWriteTime -Descending | Out-GridView -Title "Select a file" -PassThru
			$selectedname = $zipped.BaseName
			$zippeddir = $zipped.FullName
		}
		elseif ($movefromdown -eq "n") {

			directory
			start $basefolder\$filename
			Break
		}
		cls

		$zippedpath = $zipped.FullName
		$zipped = $zipped.Replace(" ", "")

		if ($zipped.Extension -eq ".zip") {

			directory
			Expand-Archive "$zipped" "$basefolder\$filename\$selectedname"
			organization
			rd $zipped -Force
		}
		elseif ($zipped.Extension -eq "") {

			directory
			Move-Item "$zippedpath" "$basefolder\$filename\$selectedname" -ErrorAction "Stop"
			organization
		}
		else {

			$zipped = $null
		}
	}
	cls

	Read-Host "Hit enter to continue"
}

elseif ($contraband -eq "y") {

	while (Test-Path "$fromscratchextracted\$filename") {

		"This file name already exists. Pick a new one."
		$filename = Read-Host	
	}

	$basefolder = $fromscratchextracted
	directory
	start $basefolder\$filename
}