#!/bin/dash
#
# COMP9044 Assignment 01 - give
#
# give-summary test
#
# Author: Aron (z5494376@ad.unsw.edu.au)
#
# Written: 3/7/2024
#
# test list:
# 1. test1: have argument
# 2. test2: sumarry successfully
#
# check tool:
# cat "$pro_output"
# echo "#############"
# cat "$exp_output"

##### give name ############
give_dir=".give"
give_order="give-summary"

####### init .give ##########
chmod a+x *
current_path=$(pwd)
give_file="$current_path/$give_order"

######## test begin ###########
echo "########## $give_order #############"
echo "test begin\n"

##### test 1 #######
num="1"
exp_output=$(mktemp)
pro_output=$(mktemp)

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

echo "usage: $give_order do not need any arguments" > "$exp_output"
"$give_file" "z1234567" 2> "$pro_output"

# check tool:
#
echo "###### test$num ############"
echo "Produced stdout or stderr:"
cat "$pro_output"
echo "##########################"
echo "Expected stdout or stderr:"
cat "$exp_output"
echo "##########################"


if diff "$pro_output" "$exp_output" > /dev/null; then
    echo "test$num passed.\n"
else 
    echo "test$num failed.\n"
fi

rm "$exp_output" "$pro_output"

##### test 2 #######
num=$((num + 1))
exp_output=$(mktemp)
pro_output=$(mktemp)
add_arguments=$(mktemp)
submit_arguments1=$(mktemp)
submit_arguments2=$(mktemp)

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi


echo "assignment lab1: submissions from 2 students" > "$exp_output"
echo "lab1 solution.sh autotest.sh mark.sh" > "$add_arguments"
echo "lab1 z1234567 ass1.sh" > "$submit_arguments1"
echo "lab1 z7654321 ass2.sh" > "$submit_arguments2"

touch solution.sh
touch autotest.sh
touch mark.sh
touch ass1.sh
touch ass2.sh

set -- $(cat "$add_arguments")
"$current_path/give-add" "$@" > /dev/null
set -- $(cat "$submit_arguments1")
"$current_path/give-submit" "$@" > /dev/null
set -- $(cat "$submit_arguments2")
"$current_path/give-submit" "$@" > /dev/null

"$give_file" >>  "$pro_output"

# check tool:
#
echo "###### test$num ############"
echo "Produced stdout or stderr:"
cat "$pro_output"
echo "##########################"
echo "Expected stdout or stderr:"
cat "$exp_output"
echo "##########################"

if diff "$pro_output" "$exp_output" > /dev/null; then
    echo "test$num passed."
else 
    echo "test$num failed."
fi

rm "$exp_output" "$pro_output" "$add_arguments" "$submit_arguments1" "$submit_arguments2"
rm "$current_path/solution.sh" "$current_path/autotest.sh" "$current_path/mark.sh" "$current_path/ass1.sh" "$current_path/ass2.sh"