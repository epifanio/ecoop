# hardcoded path to lib - change it if the $USER is not : ecoop
export PATH=/home/$USER/Envs/env1/bin:$PATH
R --no-save < installRpackages.r
R --no-save < spatialview.r
