


# 代码目录
SRC_DIR="/home/zhiyuan/Projects/wltr/"

source ${SRC_DIR}"env_setting1.sh"



TRAIN_DATE="20141113"
TEST_DATE="20141114"

echo ${APP_RANK_FILE}

	${RSCRIPT} ${SRC_DIR}"generate_test_sample1.R" \
		${TEST_SWAP_DIR} \
		${TEST_CHECK_DIR} \
		${TEST_RAW_FILE} \
		${TEST_CLEAN_FILE} \
		${TEST_BUSS_FILE}
#	${RSCRIPT} ${SRC_DIR}"build_feature.R" ${TEST_CLEAN_FILE} "test" "pc" ${PC_TEST_FILE} 
${RSCRIPT} ${SRC_DIR}"build_feature.R" ${TEST_CLEAN_FILE} "test" "app" ${APP_TEST_FILE} 
#	${RSCRIPT} ${SRC_DIR}"predict.R" ${PC_TEST_FILE}  ${PC_MODEL_FILE} ${PC_SCORE_FILE} 
	${RSCRIPT} ${SRC_DIR}"predict1.R" ${APP_TEST_FILE}  ${APP_MODEL_FILE} ${APP_SCORE_FILE} 
#	echo ${PC_RANK_FILE}
#	${RSCRIPT} ${SRC_DIR}"rerank.R" ${PC_SCORE_FILE}  ${TEST_BUSS_FILE} ${PC_RANK_FILE} "pc"
	${RSCRIPT} ${SRC_DIR}"rerank.R" ${APP_SCORE_FILE}  ${TEST_BUSS_FILE} ${APP_RANK_FILE} "app"
#	/bin/awk -f ${SRC_DIR}"join_rank.awk" ${APP_RANK_FILE} ${PC_RANK_FILE} > ${RANK_FILE}


#	N=`cat ${RANK_FILE} | wc -l`

#	if [ ${N} -lt 100000 ];then
#		rm ${RANK_FILE}
#		cp ${TMP_RANK_FILE} ${RANK_FILE}
#	fi

#	if [ ${N} -gt 100000 ];then
#		rm ${TMP_RANK_FILE}
#		cp ${RANK_FILE} ${TMP_RANK_FILE}
#	fi

#	scp -P 10022  ${RANK_FILE}  zhiyuan@10.11.3.178:/var/data/LTR/${TEST_DATE}


