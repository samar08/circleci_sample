#export METALLBVERSION=($(jq ".components[0].version" version.json))
echo  export METALLBVERSION="new_latest" >> ~/.bashrc
#echo ${METALLBVERSION}