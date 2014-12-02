#!/usr/bin/env bash


train_date=`date -d yesterday +%Y%m%d`
test_date=`date  +%Y%m%d`

#train_date="20141103"
#test_date="20141104"
data_dir="/home/zhiyuan/Projects/data/"
exec_dir="/home/zhiyuan/Projects/wltr/"
RSCRIPT="/usr/local/bin/Rscript"


train_feature=${data_dir}${train_date}".train"
test_feature=${data_dir}${test_date}".train"
test_source=${data_dir}${test_date}".clean"
train_source=${data_dir}${train_date}".clean"
test_raw=${data_dir}${test_date}
train_raw=${data_dir}${train_date}


pc_train=${data_dir}${train_date}".train.pc"
pc_label=${data_dir}${test_date}".pc.label"
pc_model=${data_dir}${train_date}".pc.model"
step=1000

${RSCRIPT}  ${exec_dir}"train.R"  "${pc_train}" "${pc_label}" ${pc_model} ${step}  
