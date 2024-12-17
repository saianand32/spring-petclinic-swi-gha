#!/bin/sh

echo ${CARL_HOME}

SOURCES="${CARL_HOME}/sources"
OUTPUT="${CARL_HOME}/output"
SOURCES_WRK="${CARL_HOME}/sources_wrk"
OUTPUT_WRK="${CARL_HOME}/output_wrk"
LOGS="${OUTPUT_WRK}/Log/"
CONF="${CARL_HOME}/configFile.xml"
PROFILER="${CARL_HOME}/Profiler/profiler-results.json"

main()
{
	mkdir -p ${SOURCES} ${OUTPUT} ${SOURCES_WRK} ${OUTPUT_WRK}
	
        ls -alsht ${SOURCES}
	cp -r ${SOURCES}/*  ${SOURCES_WRK}/
        ls -alsht ${SOURCES_WRK}

	local options="-a ${APP} -s ${SOURCES_WRK} -o ${OUTPUT_WRK} -t ${LOGS}"
	local tcc_options="-n ${APP} -i ${OUTPUT_WRK} -w ${OUTPUT_WRK}/Transactions -l ${LOGS}/Transactions.castlog"

	if [ -f "${PROFILER}" ]; then
		echo "[INFO] Profiler provided."
		options+=" -d ${PROFILER}"
	else
		echo "[INFO] No profiler provided."
	fi
	if [ -f "${CONF}" ]; then
		echo "[INFO] Configuration file provided."
		options+=" -c ${CONF}"
	else
		echo "[INFO] No configuration file provided."
	fi
	echo "[INFO] Starting CARL."
	carlengine ${options}


	echo "[INFO] Starting CARL TCC."
	carltcc ${tcc_options}

        ls -alsht ${OUTPUT_WRK}
	cp -r ${OUTPUT_WRK}/*  ${OUTPUT}/
        ls -alsht ${OUTPUT}

}

main
