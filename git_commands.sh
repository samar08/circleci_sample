#install git commands
#sudo apt-add-repository ppa:git-core/ppa
#sudo apt-get update
#sudo apt-get install git
#git --version

# configure git and git push commands
git config --global user.name "samar08"
git config --global user.email "samarasimhareddy.mohan@gmail.com"
git config --global --list
git clone https://github.com/samar08/lcm_argocd.git
cd lcm_argocd

echo 'python /dev/updateimageversion'
python ./dev/updateImageVersion.py
echo 'git add'
git add .
echo 'git commit'
git commit -m "updated image version to ${METALLBVERSION}"
echo 'git push origin...'
git push origin
cd ..
