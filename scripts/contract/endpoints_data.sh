#!/bin/bash

function setup_contract_envs()
{
    PATH_TO_CONTRACT_TEST=$(cat config.yml | grep path_to_contract_test | awk '{print $2}')
    FILE_WITH_TESTING_FILES_NAMES="tests.txt"
    FILE_WITH_ENDPOINTS_BY_FILE="list_endepoints.txt"
    FILE_WITH_CONTRACT_SCENARIO_BY_FILE="list_contract_scenarios.txt"
}

function check_tag_for_contract_test
{
  CONTENT=$(cat config.yml | grep path_to_contract_test)
  if [ -z "$CONTENT" ]; then
    STATUS="false"
  else
    STATUS="true"
  fi
}

function check_folder_of_contract_test
{
  if [ ! -d "$PATH_TO_CONTRACT_TEST" ]; then
    echo -e "\033[31;1mFolder not found in: '$PATH_TO_CONTRACT_TEST' in tag: 'path_to_contract_test'. \nPlease, set a correct path to contract test or remove this tag from config.yml \033[m"
    exit 1
  fi
}

function get_testing_files_name
{ 
  CONTENT=$(ls $PATH_TO_CONTRACT_TEST | grep 'testing')
  if [ -z "$CONTENT" ]; then
    echo -e "\033[31;1mIt was not found any file named with 'testing' in folder: '$PATH_TO_CONTRACT_TEST' \nPlease set correct folder with contrac tests or add 'testing' in all contract test file names!\033[m"
  else
    ls $PATH_TO_CONTRACT_TEST | grep 'testing' >> $FILE_WITH_TESTING_FILES_NAMES
  fi
}


function get_tested_endpoints_by_file
{
  cat $PATH_TO_CONTRACT_TEST$LINE | grep 'const' | grep 'PATH_' | awk '{print $2}' >> $FILE_WITH_ENDPOINTS_BY_FILE
}

function get_contract_scenarios_by_file
{
  cat $PATH_TO_CONTRACT_TEST$LINE | grep 'it(' >> $FILE_WITH_CONTRACT_SCENARIO_BY_FILE
}
