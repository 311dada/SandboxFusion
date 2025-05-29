#!/bin/bash
set -o errexit

USE_OFFICIAL_SOURCE=0
for arg in "$@"
do
    if [ "$arg" = "us" ]; then
        USE_OFFICIAL_SOURCE=1
    fi
done

python3 -m venv /tmp/sandbox-runtime
source /tmp/sandbox-runtime/bin/activate

if [ $USE_OFFICIAL_SOURCE -eq 0 ]; then
    pip3 config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
fi

pip3 install setuptools wheel Cython==3.0.6 numpy

pip3 install -r ./requirements.txt --ignore-requires-python

# for NaturalCodeBench python problem 29
python3 -c "import nltk; nltk.download('punkt')"

# for CIBench nltk problems 
python3 -c "import nltk; nltk.download('stopwords')"

pip cache purge
deactivate
