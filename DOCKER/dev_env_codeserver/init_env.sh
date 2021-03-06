#!/bin/zsh

my_python_projects=(inv)
my_other_project=(code_bak ImageBuilder-Docker-OpenWRT)
my_mod=(csvds transaction)

export http_proxy="http://192.168.1.2:7890"
export https_proxy="http://192.168.1.2:7890"

git config --global http.proxy socks5://192.168.1.2:7891
git config --global https.proxy socks5://192.168.1.2:7891
git config --global user.email "laye0619@gmail.com"
git config --global user.name "laye0619"


# promote the github token if needed
echo -n 'Need to git clone project? (y/n) '
read if_clone
if [[ $if_clone = y ]]
then
    echo -n 'Input github token: '
    read github_token
fi

# setup my conda env
source /home/coder/conda/bin/activate base
conda update -y --all \

# create 'general' env
conda create -y -n general python==3.9.12
if [[ $if_clone = y ]]
then
    mkdir /home/coder/project/general
fi

# git clone my other projects and create and config env for them
if [[ $if_clone = y ]]
then
    for var in ${my_other_project[*]}
    do
        git clone https://laye0619:$github_token@github.com/laye0619/$var.git /home/coder/project/$var
    done
fi

# git clone my python projects and create and config env for them
for var in ${my_python_projects[*]}
do
    if [[ $if_clone = y ]]
    then
        git clone https://laye0619:$github_token@github.com/laye0619/$var.git /home/coder/project/$var
    fi

    conda create -y -n $var python==3.9.12
    source /home/coder/conda/bin/activate $var
    conda install -n $var ipykernel --update-deps --force-reinstall -y
    pip install -r /home/coder/project/$var/requirements.txt


    if [[ $var = inv ]];
    then
        conda install -y -c conda-forge ta-lib
        rqalpha download-bundle
        for mod in ${my_mod[*]}
        do
            pip install -e /home/coder/project/$var/backtest/rqalpha-mod-$mod
        done
    fi
done

conda clean --all -f -y
