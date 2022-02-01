#export METALLBVERSION=($(jq ".components[0].version" version.json))
echo  export METALLBVERSION="old_version" >> ~/.bashrc
#echo ${METALLBVERSION}