#!/bin/sh

LINENODECHAR="+"
LINECONNCHAR="-"
DATANODECHAR="|"
LEFTMARGINCHAR=" "

tbl_set_col_max(){
  export TBLCOLMAX=$1
}

tbl_get_col_max(){
  echo $TBLCOLMAX
}

tbl_set_title(){
  it=0
  for st in $*
  do
    TBLTITLE[$it]=$st
    it=`expr $it + 1`
  done
}

tbl_get_title(){
  echo ${TBLTITLE[*]}
}

tbl_set_size(){
  i=0
  for s in $*
  do
    TBLSIZE[$i]=$s
    i=`expr $i + 1`
  done
}

tbl_get_size(){
  echo ${TBLSIZE[*]}
}

tbl_set_data(){
  i=0
  for s in $*
  do
    TBLDATA[$i]=$s
    i=`expr $i + 1`
  done
}

tbl_get_data(){
  echo ${TBLDATA[*]}
}

tbl_set_left_margin(){
  TBLLEFTMARGIN=$1
}

tbl_get_left_argin(){
  echo $TBLLEFTMARGIN
}

tbl_print_left_margin(){
  imargin=0
  while [ $imargin -lt ${TBLLEFTMARGIN} ];
  do
    echo -n "${LEFTMARGINCHAR}"
    imargin=`expr $imargin + 1`
  done
}
tbl_print_title_botom(){
  ibot=0
  while [ $ibot -lt ${TBLCOLMAX} ];
  do
    if [ $ibot -eq 0 ]; then
      tbl_print_left_margin
      echo -n "${LINENODECHAR}"
    fi

    SIZEINF=${TBLSIZE[$ibot]}
    jbot=0
    while [ $jbot -lt ${SIZEINF} ];
    do
      echo -n "${LINECONNCHAR}"
      jbot=`expr $jbot + 1`
    done
    echo -n "${LINENODECHAR}"

    ibot=`expr $ibot + 1`
  done
  echo
}

tbl_print_title_content(){
  ititle=0
  while [ $ititle -lt ${TBLCOLMAX} ];
  do
    if [ $ititle -eq 0 ]; then
      tbl_print_left_margin
      echo -n "${DATANODECHAR}"
    fi

    SIZEINF=${TBLSIZE[$ititle]}
    TITLEINF=${TBLTITLE[$ititle]}

    echo -n "${TITLEINF}" |awk '{printf("%-'"${SIZEINF}"'s",$0)}'
    echo -n "${DATANODECHAR}"

    ititle=`expr $ititle + 1`
  done
  echo
}

tbl_print_title(){
  tbl_print_title_botom
  tbl_print_title_content
  tbl_print_title_botom
}

tbl_print_data_content(){
  ititle=0
  while [ $ititle -lt ${TBLCOLMAX} ];
  do
    if [ $ititle -eq 0 ]; then
      tbl_print_left_margin
      echo -n "${DATANODECHAR}"
    fi

    SIZEINF=${TBLSIZE[$ititle]}
    DATAINF=${TBLDATA[$ititle]}

    echo -n "${DATAINF}" |awk '{printf("%-'"${SIZEINF}"'s",$0)}'
    echo -n "${DATANODECHAR}"

    ititle=`expr $ititle + 1`
  done
  echo
}

tbl_print_data(){
  tbl_print_data_content
  tbl_print_title_botom
}

show_process_status(){
  STATUS="$1"
  YAMLFILE="${ROOT_DIR}/config/${2}.yaml"

  #print data
  tbl_set_col_max 2
  tbl_set_left_margin 1
  tbl_set_size 20 40
  tbl_set_title TYPE STATUS
  tbl_print_title

  tbl_set_data "$2" "$1"
  tbl_print_data
}

TEMP_LOG_FILE=/tmp/pipeline_devops_docker.log.$$

pull_docker_image(){
  image_name="$1"
  echo "#   Image: ${image_name}"
  docker images |grep ${image_name} 2>/dev/null
  if [ $? -ne 0 ]; then
    docker pull ${image_name}
  fi
  echo
}

capability_mgnt(){
  action="$1"
  capa="$2"
  port="$3"
  SLEEP_TIME=3

  echo "## ${capa} ${port}: ${action} begins ..."
  docker-compose ${action} ${capa} >>$TEMP_LOG_FILE 2>&1 &
  sleep 3
  echo "## ${capa} ${port}: ${action} end    ..."
  echo
}

date
echo "## pipeline init ..."
for image in base ci-jenkins cov-hyapi com-mongo cov-sonarqube cov-hygui \
    ca-wekan ca-jira scm-artifactory scm-gitlab
do
  pull_docker_image devopsopen/docker-${image}
done
date

echo "## pipeline up "
capability_mgnt up mongo 27017
capability_mgnt up cap_scm 9010
capability_mgnt up artifactory 9011
capability_mgnt up cap_ca 9090
capability_mgnt up jira 9091
capability_mgnt up hyapi 8080
capability_mgnt up hygui 9088
capability_mgnt up cap_ci 9080
capability_mgnt up cap_cq 9092

echo "## pipeline ps "
docker-compose ps
echo

echo "## confirm log result: ${TEMP_LOG_FILE}"
