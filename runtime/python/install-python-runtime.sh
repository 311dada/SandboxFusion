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
    pip config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
fi

pip install -r ./requirements.txt --ignore-requires-python

# for NaturalCodeBench python problem 29
python -c "import nltk; nltk.download('punkt')"

# for CIBench nltk problems 
python -c "import nltk; nltk.download('stopwords')"

pip cache purge
deactivate
