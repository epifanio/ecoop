# hardcoded path to lib - change it if the $USER is not : ecoop
export PATH=/home/$USER/Envs/env1/bin:$PATH
mkdir -p /home/$USER/Envs/env1/lib64/R/library/
R --no-save < installRpackages.r
R --no-save < install_spatial_view.r
