@echo off
SET _inputFile=%1
SET _OUTPUTFOLDER=%2
SET _TARGET=%3
SET _CONFIG=%4
SET _PMA=%5
SET _RENBURG=%6
SET _NO_OF_ENV=%7

setlocal enableextensions enabledelayedexpansion
@set /a _NO_OF_ENV_PROP=0
@set _FILE=''
@SET arr[0][0]=''
@SET key[0]=''
FOR /F "usebackq tokens=1-6 delims=," %%A IN (%_inputFile%) DO (
	IF !_NO_OF_ENV_PROP! == 0 (
		MKDIR %_OUTPUTFOLDER%\%_TARGET%\%%B\%_CONFIG%
		MKDIR %_OUTPUTFOLDER%\%_TARGET%\%%C\%_CONFIG%
		MKDIR %_OUTPUTFOLDER%\%_TARGET%\%%D\%_CONFIG%
		MKDIR %_OUTPUTFOLDER%\%_TARGET%\%%E\%_CONFIG%
		
		COPY %_OUTPUTFOLDER%\%_CONFIG%\*.* %_OUTPUTFOLDER%\%_TARGET%\%%B\%_CONFIG%\.
		COPY %_OUTPUTFOLDER%\%_CONFIG%\*.* %_OUTPUTFOLDER%\%_TARGET%\%%C\%_CONFIG%\.
		COPY %_OUTPUTFOLDER%\%_CONFIG%\*.* %_OUTPUTFOLDER%\%_TARGET%\%%D\%_CONFIG%\.
		COPY %_OUTPUTFOLDER%\%_CONFIG%\*.* %_OUTPUTFOLDER%\%_TARGET%\%%E\%_CONFIG%\.
	)
	
	@SET key[!_NO_OF_ENV_PROP!]=%%A
	@SET arr[0][!_NO_OF_ENV_PROP!]=%%B
	@SET arr[1][!_NO_OF_ENV_PROP!]=%%C
	@SET arr[2][!_NO_OF_ENV_PROP!]=%%D
	@SET arr[3][!_NO_OF_ENV_PROP!]=%%E
	@set /a _NO_OF_ENV_PROP+=1
)

@SET /a _START=0
FOR /L %%t IN (%_START%,1,%_NO_OF_ENV%) DO (
	@SET value=''
	(FOR /F "tokens=1,2 delims==" %%i IN (%_OUTPUTFOLDER%\%_CONFIG%\%_PMA%) DO (
			@SET value=%%j
			FOR /L %%u IN (1,1,%_NO_OF_ENV_PROP%) DO (
				@SET search=@!key[%%u]!@
				IF !search!==%%j (
					@SET value=!arr[%%t][%%u]!
				)
			)
			IF !value! == "" (
				echo %%i
			) ELSE (
				echo %%i=!value!
			)
	))>"%_OUTPUTFOLDER%\%_TARGET%\!arr[%%t][0]!\%_CONFIG%\%_PMA%"
)
endlocal