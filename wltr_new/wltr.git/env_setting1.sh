#!/usr/bin/env bash


TRAIN_DATE=`date -d yesterday +%Y%m%d`
TEST_DATE=`date  +%Y%m%d`

TRAIN_DATE="20141113"
TEST_DATE="20141114"
# 数据目录
DATA_DIR="/home/zhiyuan/Projects/data/"
# 代码目录
SRC_DIR="/home/zhiyuan/Projects/wltr/"
# R目录
RSCRIPT="/usr/local/bin/Rscript"



# 原始中转数据路径
TRAIN_SWAP_DIR="/var/data/dataForLTR/${TRAIN_DATE}/"
TEST_SWAP_DIR="/var/data/dataForLTR/${TEST_DATE}/"

# 原始中转数据路径
TRAIN_CHECK_DIR="/var/data/dataForLTR3/${TRAIN_DATE}/"
TEST_CHECK_DIR="/var/data/dataForLTR3/${TEST_DATE}/"


# 训练原始数据文件
TRAIN_RAW_FILE=${DATA_DIR}${TRAIN_DATE}
# 测试原始数据文件
TEST_RAW_FILE=${DATA_DIR}${TEST_DATE}

# 训练原始数据文件
TRAIN_BUSS_FILE=${DATA_DIR}${TRAIN_DATE}".buss"
# 测试原始数据文件
TEST_BUSS_FILE=${DATA_DIR}${TEST_DATE}".buss"


# 训练数据的清洗后文件
TRAIN_CLEAN_FILE=${DATA_DIR}${TRAIN_DATE}".clean"
# 测试数据的清洗后文件
TEST_CLEAN_FILE=${DATA_DIR}${TEST_DATE}".clean"


echo "${TEST_BUSS_FILE}"

# PC训练数据文件
PC_TRAIN_FILE=${DATA_DIR}${TRAIN_DATE}".pc.train"
# APP训练数据文件
APP_TRAIN_FILE=${DATA_DIR}${TRAIN_DATE}".app.train"


# PC标注样本数据文件
PC_LABEL_FILE=${DATA_DIR}${TEST_DATE}".pc.label"
# APP标注样本数据文件
APP_LABEL_FILE=${DATA_DIR}${TEST_DATE}".app.label"



# PC model文件
PC_MODEL_FILE=${DATA_DIR}${TRAIN_DATE}".pc.model"
# APP model文件
APP_MODEL_FILE=${DATA_DIR}${TRAIN_DATE}".app.model"



# PC score文件
PC_SCORE_FILE=${DATA_DIR}${TEST_DATE}".pc.score"
# APP model文件
APP_SCORE_FILE=${DATA_DIR}${TEST_DATE}".app.score"

# PC测试数据文件
PC_TEST_FILE=${DATA_DIR}${TEST_DATE}".pc.test"
# APP测试数据文件
APP_TEST_FILE=${DATA_DIR}${TEST_DATE}".app.test"



# PC rank数据文件
PC_RANK_FILE=${DATA_DIR}${TEST_DATE}".pc.rank"
# APP rank数据文件
APP_RANK_FILE=${DATA_DIR}${TEST_DATE}".app.rank"
RANK_FILE=${DATA_DIR}${TEST_DATE}".rank"

TMP_RANK_FILE="${DATA_DIR}tmp.rank"
