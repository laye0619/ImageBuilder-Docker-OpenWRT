#!/bin/zsh

my_projects=(backtest_rqalpha my_portfolio_analysis ofanalysis)

export http_proxy="http://192.168.1.2:7890"
export https_proxy="http://192.168.1.2:7890"

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

# git clone my projects and create and config env for them
for var in ${my_projects[*]}
do
    if [[ $if_clone = y ]]
    then
        git clone https://laye0619:$github_token@github.com/laye0619/$var.git /home/coder/project/$var
    fi

    conda create -y -n $var python==3.9.12
    source /home/coder/conda/bin/activate $var
    conda install -n $var ipykernel --update-deps --force-reinstall -y
    pip install -r /home/coder/project/$var/requirements.txt
    if [[ $var = backtest_rqalpha ]];
    then
        rqalpha download-bundle
    fi
done

conda clean --all -f -y
