#export METALLBVERSION=($(jq ".components[0].version" version.json))
export METALLBVERSION="new_latest"
#echo ${METALLBVERSION}