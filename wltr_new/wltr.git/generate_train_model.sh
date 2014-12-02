


# 代码目录
SRC_DIR="/home/zhiyuan/Projects/wltr/"

source ${SRC_DIR}"env_setting.sh"

#if [ ! -f ${TRAIN_CLEAN_FILE} ];then
	echo "now generate train"
	${RSCRIPT} ${SRC_DIR}"generate_train_sample.R" \
		${TRAIN_SWAP_DIR} \
		${TRAIN_CHECK_DIR} \
		${TRAIN_RAW_FILE} \
		${TRAIN_CLEAN_FILE} 
	${RSCRIPT} ${SRC_DIR}"generate_train_sample.R" \
		${TEST_SWAP_DIR} \
		${TEST_CHECK_DIR} \
		${TEST_RAW_FILE} \
		${TEST_CLEAN_FILE} 
	echo "label pc"
	${RSCRIPT} ${SRC_DIR}"build_feature.R" ${TRAIN_CLEAN_FILE} "train" "pc" ${PC_TRAIN_FILE}
	echo "label app"
	${RSCRIPT} ${SRC_DIR}"build_feature.R" ${TRAIN_CLEAN_FILE} "train" "app" ${APP_TRAIN_FILE}
	echo "label"
	${RSCRIPT} ${SRC_DIR}"label_sample.R" ${TEST_CLEAN_FILE} ${PC_LABEL_FILE} ${APP_LABEL_FILE}
	echo "train"
	${RSCRIPT} ${SRC_DIR}"train.R" ${PC_TRAIN_FILE} ${PC_LABEL_FILE} ${PC_MODEL_FILE} 1000
    ${RSCRIPT} ${SRC_DIR}"train.R" ${APP_TRAIN_FILE} ${APP_LABEL_FILE} ${APP_MODEL_FILE} 1000

#fi 
