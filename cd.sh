#!/bin/bash

URL="http://192.168.2.136/software/release/deepvideo_release/"
SHELL_DIR="$(cd $(dirname $0); pwd)"
SHELL_LOG="${SHELL_DIR}/logs/cd.log"
DEEP_DIR="${SHELL_DIR}/deep"
TEST_URL="http://127.0.0.1:8050"




function logging(){
    if [[ ! -d ${SHELL_DIR}"/logs" ]];then
        mkdir -p ${SHELL_DIR}"/logs"
        mkdir -p ${DEEP_DIR}
    fi
    LOG_INFO="[$(date "+%Y-%m-%d") $(date "+%H:%M:%S")] $1"
    echo ${LOG_INFO}
    echo ${LOG_INFO} >> ${SHELL_LOG}
}


function run() {
    $1 | tee -a $SHELL_LOG
    return ${PIPESTATUS[0]}
}


function downloadApp(){
    logging "downloadApp $1 $2.tar.gz"
    if [ $1 == "croatia" ];then
        cd $DEEP_DIR/$1-video
    else
        cd $DEEP_DIR/$1
    fi
    if [[  -L latest ]];then
        rm -f latest
    fi

    if [ $1 == "arcee_captured" ] || [ $1 == "arcee_registered" ];then
       cd $DEEP_DIR/$1
        if [[  -L latest ]];then
            rm -f latest
        fi
       wget -q  -c ${URL}arcee/$2.tar.gz && tar zxvf $2.tar.gz && ln -s $2 latest && rm -f $2.tar.gz
    else
       wget -q  -c ${URL}$1/$2.tar.gz && tar zxvf $2.tar.gz && ln -s $2 latest && rm -f $2.tar.gz
    fi
}

function downloadDeepEmpty(){
    logging "download deepempty"
    cd $SHELL_DIR
    #wget $URL/deepmodel/deep_model.tgz && tar zxvf deep_model.tgz && rm -f deep_model.tgz
    wget $TEST_URL/deep_model.tgz && tar zxvf deep_model.tgz && rm -f deep_model.tgz
    if [[ $? != 0 ]];then
        logging "ERROR: download deep error" 
    fi
}

#function downloadVsd(){
#    run "downloadApp vsd vsd-1.0.16"
#    if [[ $? != 0 ]];then
#        logging "ERROR: down vsd error" 
#    fi
#}

function downloadArcee_captured(){
    logging "download arcee_captured"
    run "downloadApp arcee_captured arcee-$1"
    #run "downloadApp arcee_captured arcee-0.5.4"
    if [[ $? != 0 ]];then
        logging "ERROR: down arcee_captured error" 
    fi
}

function downloadArcee_registered(){
    logging "download arcee_registered"
    run "downloadApp arcee_registered arcee-$1"
    #run "downloadApp arcee_registered arcee-0.5.4"
    if [[ $? != 0 ]];then
        logging "ERROR: down arcee_registered error" 
    fi
}


function downloadCroatia-video(){
    run "downloadApp croatia croatia-video$1"
    #run "downloadApp croatia croatia-video1.8.3_vse"
    if [[ $? != 0 ]];then
        logging "ERROR: download croatia error" 
    fi
}

function downloadCrusader(){
    run "downloadApp crusader crusader-$1" 
    #run "downloadApp crusader crusader-2.5.1" 
    if [[ $? != 0 ]];then
        logging "ERROR: download crusader error" 
    fi
}
function downloadFse(){
    run "downloadApp fse fse-$1" 
    #run "downloadApp fse fse-3.5.0" 
    if [[ $? != 0 ]];then
        logging "ERROR: download fse error" 
    fi
   
}

function downloadMonk(){
    logging "download monk"
}

function downloadPrep(){
    run "downloadApp prep prep-$1"
    #run "downloadApp prep prep-0.1.1"
    if [[ $? != 0 ]];then
        logging "ERROR: download prep error" 
    fi
}

function downloadThor(){
    run "downloadApp thor thor-$1"
    #run "downloadApp thor thor-2.5.4_vse"
    if [[ $? != 0 ]];then
        logging "ERROR: download thor error" 
    fi
}
#todo how to make config file 

downloadDeepEmpty
downloadArcee_captured 0.5.4
downloadArcee_registered 0.5.4
downloadCroatia-video 1.8.3_vse
downloadCrusader 2.5.1
downloadFse 3.5.0
downloadPrep 0.1.1
downloadThor 2.5.4_vse
