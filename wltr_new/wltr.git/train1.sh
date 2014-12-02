#!/usr/bin/env bash


#train_date=`date -d yesterday +%Y%m%d`
#test_date=`date  +%Y%m%d`

train_date="20141015"
test_date="20141016"
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
pc_label=${data_dir}${test_date}".pc.label"
app_label=${data_dir}${test_date}".app.label"
pc_model=${data_dir}${train_date}".pc.model"
app_model=${data_dir}${train_date}".app.model"

step=100

echo ${test_date}
#${RSCRIPT}  ${exec_dir}"manageData.R" ${test_date} ${test_raw} ${test_source}
echo ${test_date}
#${RSCRIPT}  ${exec_dir}"manageData.R" ${train_date} ${train_raw} ${train_source}
echo ${test_date}
${RSCRIPT}  ${exec_dir}"buildFeatures2.R"  ${train_source} ${train_raw} "train"
echo ${test_date}
${RSCRIPT}  ${exec_dir}"labelSample.R"  ${test_raw} 
${RSCRIPT}  ${exec_dir}"train.R"  "${pc_train}" "${pc_label}" ${pc_model} ${step}  
${RSCRIPT}  ${exec_dir}"train.R"  "${app_train}" "${app_label}" ${app_model} ${step}  
#nohup ${RSCRIPT}  ${exec_dir}"train.R"  "${app_train}" ${app_model}  ${step} > /home/zhiyuan/app_model_log &
