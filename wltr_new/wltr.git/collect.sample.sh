#!/usr/bin/env bash


train_date="${1}"
test_date="${2}"
data_dir="/home/zhiyuan/Projects/data/"
exec_dir="/home/zhiyuan/Projects/wltr/"
RSCRIPT="/usr/local/bin/Rscript"


train_feature=${data_dir}${train_date}".train"
test_feature=${data_dir}${test_date}".train"
test_source=${data_dir}${test_date}".clean"
train_source=${data_dir}${train_date}".clean"
test_raw=${data_dir}${test_date}
train_raw=${data_dir}${train_date}

tag_file=${data_dir}${test_date}".tag"

pc_feature=${data_dir}${train_date}".train.pc"
app_feature=${data_dir}${train_date}".train.app"
pc_sample=${data_dir}${train_date}".sample.pc"
app_sample=${data_dir}${train_date}".sample.app"



test_pc_gmv_label=${data_dir}${test_date}".pc.gmv.label"
test_app_gmv_label=${data_dir}${test_date}".app.gmv.label"
test_app_click_label=${data_dir}${test_date}".app.click.label"
test_pc_gmv_model=${data_dir}${train_date}".pc.gmv.model"
train_pc_gmv_sample=${data_dir}${train_date}".pc.gmv.sample"
train_app_gmv_sample=${data_dir}${train_date}".app.gmv.sample"
test_app_gmv_sample=${data_dir}${train_date}".app.gmv.sample"
test_app_gmv_model=${data_dir}${train_date}".app.gmv.model"
test_app_click_model=${data_dir}${train_date}".app.click.model"
test_gmv_score=${data_dir}${test_date}".gmv.score"
test_gmv_rank=${data_dir}${test_date}".gmv.rank"
test_score=${data_dir}${test_date}".score"
gmv_step=100

test_click_target=${data_dir}${test_date}".click.target"
test_click_model=${data_dir}${train_date}".click.model"
test_click_score=${data_dir}${test_date}".click.score"
test_click_rank=${data_dir}${test_date}".click.rank"
test_rank=${data_dir}${test_date}".rank"
step=100

#${RSCRIPT}  ${exec_dir}"manageData.R" ${test_date} ${test_raw} ${test_source}
#${RSCRIPT}  ${exec_dir}"manageData.R" ${train_date} ${train_raw} ${train_source}
${RSCRIPT}  ${exec_dir}"buildFeatures.R"  ${train_source} ${train_raw} "train"
#${RSCRIPT}  ${exec_dir}"labelSample.R"  ${test_raw} 
${RSCRIPT}  ${exec_dir}"joinTrainAndLabel.R"  ${train_feature} ${test_pc_gmv_label} ${pc_sample} 
${RSCRIPT}  ${exec_dir}"joinTrainAndLabel.R"  ${train_feature} ${test_app_gmv_label} ${app_sample} 
