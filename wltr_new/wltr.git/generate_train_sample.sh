


# 代码目录
SRC_DIR="/home/zhiyuan/Projects/wltr/"

source ${SRC_DIR}"env_setting.sh"

	echo "now generate train"
	${RSCRIPT} ${SRC_DIR}"generate_train_sample.R" \
		${TRAIN_SWAP_DIR} \
		${TRAIN_CHECK_DIR} \
		${TRAIN_RAW_FILE} \
		${TRAIN_CLEAN_FILE} 
	echo "generate train done"
