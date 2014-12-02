


# 代码目录
SRC_DIR="/home/minxing/projects/zhiyuan/wltr/"

source ${SRC_DIR}"env_setting_minxing.sh"

        echo "-------------------------------------------"
        echo "begin  predicting"

        date

	${RSCRIPT} ${SRC_DIR}"generate_test_sample1.R" \
		${TEST_SWAP_DIR} \
		${TEST_CHECK_DIR} \
		${TEST_RAW_FILE} \
		${TEST_CLEAN_FILE} \
		${TEST_BUSS_FILE}

	${RSCRIPT} ${SRC_DIR}"build_feature.R" ${TEST_CLEAN_FILE} "test" "pc" ${PC_TEST_FILE} 
	${RSCRIPT} ${SRC_DIR}"build_feature.R" ${TEST_CLEAN_FILE} "test" "app" ${APP_TEST_FILE} 
	${RSCRIPT} ${SRC_DIR}"predict.R" ${PC_TEST_FILE}  ${PC_MODEL_FILE} ${PC_SCORE_FILE} 
	${RSCRIPT} ${SRC_DIR}"predict.R" ${APP_TEST_FILE}  ${APP_MODEL_FILE} ${APP_SCORE_FILE}
       
      	${RSCRIPT} ${SRC_DIR}"weight.score.R" ${TEST_RAW_FILE} ${APP_SCORE_FILE} ${APP_SCORE_FRESH_FILE}

	${RSCRIPT} ${SRC_DIR}"rerank.R" ${PC_SCORE_FILE}  ${TEST_BUSS_FILE} ${PC_RANK_FILE} "pc"
	${RSCRIPT} ${SRC_DIR}"rerank.R" ${APP_SCORE_FILE}  ${TEST_BUSS_FILE} ${APP_RANK_FILE} "app"	
        ${RSCRIPT} ${SRC_DIR}"rerank.R" ${APP_SCORE_FRESH_FILE}  ${TEST_BUSS_FILE} ${APP_FRESH_RANK_FILE} "app"

        ${RSCRIPT} ${SRC_DIR}"merge.all.rank.R" ${PC_RANK_FILE} ${APP_RANK_FILE} ${APP_FRESH_RANK_FILE} ${RANK_FILE}".Debug"
        ${RSCRIPT} ${SRC_DIR}"convert.R" ${APP_FRESH_RANK_FILE} ${RANK_FILE}

	N=`cat ${RANK_FILE} | wc -l`

	if [ ${N} -lt 100000 ];then
		rm ${RANK_FILE}
		cp ${TMP_RANK_FILE} ${RANK_FILE}
	fi

	if [ ${N} -gt 100000 ];then
		rm ${TMP_RANK_FILE}
		cp ${RANK_FILE} ${TMP_RANK_FILE}
	fi

	scp -P 10022  ${RANK_FILE}  root@10.11.3.178:/var/data/fresh/${TEST_DATE}

        date

	echo "finish predicting"
	echo "-------------------------------------------"
