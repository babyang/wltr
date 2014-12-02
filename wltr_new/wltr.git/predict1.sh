#!/usr/bin/env bash


train_date=`date -d yesterday +%Y%m%d`
test_date=`date  +%Y%m%d`

data_dir="/home/zhiyuan/Projects/data/"
exec_dir="/home/zhiyuan/Projects/wltr/"
RSCRIPT="/usr/local/bin/Rscript"


train_feature=${data_dir}${train_date}".feature"
test_feature=${data_dir}${test_date}".test"
test_source=${data_dir}${test_date}".clean"
train_source=${data_dir}${train_date}".clean"
test_raw=${data_dir}${test_date}
train_raw=${data_dir}${train_date}

tag_file=${data_dir}${test_date}".tag"


test_rank=${data_dir}${test_date}".rank"
step=1000

pc_test=${data_dir}${test_date}".test.pc"

pc_reg=${data_dir}${train_date}".pc.reg"
reg_score=${data_dir}${test_date}".reg.score"

reg_rank=${data_dir}${test_date}".reg.rank"

#${RSCRIPT}  ${exec_dir}"manageData.R" ${test_date} ${test_raw} ${test_source}
#${RSCRIPT}  ${exec_dir}"buildFeatures.R"  ${test_source} ${test_raw} "test"
#${RSCRIPT}  ${exec_dir}"predict.R"  ${pc_test} ${pc_model}  ${pc_score}
${RSCRIPT}  ${exec_dir}"predict.R"  ${pc_test} ${pc_reg}  ${reg_score}

${RSCRIPT}  ${exec_dir}"merge.rank.R" ${tag_file}  ${reg_score} ${reg_rank} 
#${RSCRIPT}  ${exec_dir}"merge.rank.R" ${tag_file}  ${pc_score} ${pc_rank} 
#/bin/awk -f ${exec_dir}"join_rank.awk" ${app_rank} ${pc_rank} > ${test_rank}
#scp -P 10022  ${test_rank}  zhiyuan@10.11.3.178:/var/data/LTR/${test_date}
