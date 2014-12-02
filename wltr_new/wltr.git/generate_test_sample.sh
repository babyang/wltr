


# 代码目录
SRC_DIR="/home/zhiyuan/Projects/wltr/"

source ${SRC_DIR}"env_setting.sh"

echo "now generate test"
	${RSCRIPT} ${SRC_DIR}"generate_test_sample.R" ${TEST_SWAP_DIR} ${TEST_RAW_FILE} ${TEST_CLEAN_FILE} ${TEST_BUSS_FILE}
echo "generate test done"
