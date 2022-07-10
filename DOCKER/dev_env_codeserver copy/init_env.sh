#!/bin/zsh

for var in backtest_rqalpha my_portfolio_analysis ofanalysis
do
    source /home/coder/conda/bin/activate $var
    conda install -n $var ipykernel --update-deps --force-reinstall -y
    pip install -r /home/coder/project/$var/requirements.txt
    if [[ $var = backtest_rqalpha ]];
    then
        rqalpha download-bundle
    fi
done

