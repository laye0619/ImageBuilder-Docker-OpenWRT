#!/bin/zsh

# setup my conda env
conda update -y --all \

for var in backtest_rqalpha my_portfolio_analysis ofanalysis
do
    conda create -y -n $var python==3.9.12
    source /home/coder/conda/bin/activate $var
    conda install -n $var ipykernel --update-deps --force-reinstall -y
    curl -H "Authorization: token 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" https://raw.githubusercontent.com/laye0619/backtest_rqalpha/master/requirements.txt >> /home/coder/requirement.txt
    pip install -r /home/coder/requirements.txt
    rm /home/coder/requirements.txt
    if [[ $var = backtest_rqalpha ]];
    then
        rqalpha download-bundle
    fi
done

conda clean --all -f -y

