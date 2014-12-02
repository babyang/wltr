#!/usr/bin/env bash


train_date=`date -d yesterday +%Y%m%d`
test_date=`date  +%Y%m%d`
test_date="20141106"
train_date="20141105"

data_dir="/home/zhiyuan/Projects/data1/"
exec_dir="/home/zhiyuan/Projects/wltr/"
RSCRIPT="/usr/local/bin/Rscript"


train_feature=${data_dir}${train_date}".train"
test_feature=${data_dir}${test_date}".train"
test_source=${data_dir}${test_date}".clean"
train_source=${data_dir}${train_date}".clean"
test_raw=${data_dir}${test_date}
train_raw=${data_dir}${train_date}

tag_file=${data_dir}${test_date}".tag"

pc_train=${data_dir}${train_date}".train.pc"
app_train=${data_dir}${train_date}".train.app"
reg_label=${data_dir}${test_date}".reg.label"
pc_reg=${data_dir}${train_date}".pc.reg"

step=1000

#${RSCRIPT}  ${exec_dir}"manageData.R" ${train_date} ${train_raw} ${train_source}
#${RSCRIPT}  ${exec_dir}"manageData.R" ${test_date} ${test_raw} ${test_source}
#${RSCRIPT}  ${exec_dir}"buildFeatures.R"  ${train_source} ${train_raw} "train"
${RSCRIPT}  ${exec_dir}"buildFeatures2.R"  ${test_source} ${test_raw} "test"
#${RSCRIPT}  ${exec_dir}"labelTarget.R"  ${test_raw} 
#${RSCRIPT}  ${exec_dir}"regression.R"  "${pc_train}" "${reg_label}" ${pc_reg} ${step}  
