#!/bin/dash
#
# COMP9044 Assignment 01 - give
#
# give-rm test
#
# Author: Aron (z5494376@ad.unsw.edu.au)
#
# Written: 3/7/2024
#
# test list:
# 1. test1: no argument
# 2. test2: no assignment exists
# 3. test3: remove assignment successfully
#
# check tool:
# cat "$pro_output"
# echo "#############"
# cat "$exp_output"

##### give name ############
give_dir=".give"
give_order="give-rm"

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

echo "usage: $give_order <assignment>" > "$exp_output"
"$give_file" 2> "$pro_output"

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
arguments=$(mktemp)

echo "directory .give created\nassignment lab2 created\nCan not find lab1" > "$exp_output"
echo "lab2 solution.sh autotest.sh mark.sh" > "$arguments"

touch solution.sh
touch autotest.sh
touch mark.sh

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

if test -s "$arguments"; then
    set -- $(cat "$arguments")
    "$current_path/give-add" "$@" > "$pro_output"
    "$give_file" "lab1" >>  "$pro_output"
fi

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

rm "$exp_output" "$pro_output" "$arguments"
rm  "$current_path/solution.sh" "$current_path/autotest.sh" "$current_path/mark.sh"

##### test 3 #######
num=$((num + 1))
exp_output=$(mktemp)
pro_output=$(mktemp)
arguments=$(mktemp)

echo "directory .give created\nassignment lab1 created\nassignment lab1 removed" > "$exp_output"
echo "lab1 solution.sh autotest.sh mark.sh" > "$arguments"

touch solution.sh
touch autotest.sh
touch mark.sh

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

if test -s "$arguments"; then
    set -- $(cat "$arguments")
    "$current_path/give-add" "$@" > "$pro_output"
    "$give_file" "lab1" >>  "$pro_output"
fi

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

rm "$exp_output" "$pro_output" "$arguments"
rm  "$current_path/solution.sh" "$current_path/autotest.sh" "$current_path/mark.sh"