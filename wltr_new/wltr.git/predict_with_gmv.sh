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
step=100

pc_test=${data_dir}${test_date}".test.pc"
app_test=${data_dir}${test_date}".test.app"

pc_model=${data_dir}${train_date}".pc.model"
app_model=${data_dir}${train_date}".app.model"
pc_score=${data_dir}${test_date}".pc.score"
app_score1=${data_dir}${test_date}".app.score1"
app_score=${data_dir}${test_date}".app.score"

pc_rank=${data_dir}${test_date}".pc.rank"
app_rank=${data_dir}${test_date}".app.rank"
app_rank2=${data_dir}${test_date}".app.rank2"
app_modify_rank=${data_dir}${test_date}".app.score.modified"
tmp_rank=${data_dir}${test_date}".tmp"
test_rank=${data_dir}${test_date}".rank"

cp ${app_score} ${app_score1}
${RSCRIPT}  ${exec_dir}"merge.rank1.R" ${tag_file}  ${app_score1} ${app_score} 
${RSCRIPT}  ${exec_dir}"weight.score.R" ${test_date}  ${train_date} ${app_modify_rank} 
/bin/awk -f ${exec_dir}"join_rank.awk" ${app_modify_rank} ${tmp_rank} > ${test_rank}

scp -P 10022  ${test_rank}  zhiyuan@10.11.3.178:/var/data/LTR/${test_date}
