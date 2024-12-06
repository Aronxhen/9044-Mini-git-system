#!/bin/dash
#
# COMP9044 Assignment 01 - give
#
# give-fetch test
#
# Author: Aron (z5494376@ad.unsw.edu.au)
#
# Written: 3/7/2024
#
# test list:
# 1. test1: no argument
# 2. test2: no assignment
# 3. test3: no submission for zid (no zid folder)
# 4. test4: no submission for zid (the zid folder is empty)
#
# check tool:
# cat "$pro_output"
# echo "#############"
# cat "$exp_output"

##### give name ############
give_dir=".give"
give_order="give-fetch"

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

echo "usage: $give_order <assignment> <zid> [n]" > "$exp_output"
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
add_arguments1=$(mktemp)
submit_arguments1=$(mktemp)

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

echo "directory .give created\nassignment lab1 created\n$give_order: assignment lab2 not found" > "$exp_output"
echo "lab1 solution.sh autotest.sh mark.sh" > "$add_arguments1"
echo "lab2 z1234567 1" > "$submit_arguments1"

touch solution.sh
touch autotest.sh
touch mark.sh
touch ass1.sh

set -- $(cat "$add_arguments1")
"$current_path/give-add" "$@" > "$pro_output"
set -- $(cat "$submit_arguments1")
"$give_file" "$@" 2>> "$pro_output"

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

rm "$exp_output" "$pro_output" "$add_arguments1" "$submit_arguments1"
rm "$current_path/solution.sh" "$current_path/autotest.sh" "$current_path/mark.sh" "$current_path/ass1.sh"


##### test 3 #######
num=$((num + 1))
exp_output=$(mktemp)
pro_output=$(mktemp)
add_arguments1=$(mktemp)
submit_arguments1=$(mktemp)

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

echo "directory .give created\nassignment lab1 created\nno submissions for z1234567" > "$exp_output"
echo "lab1 solution.sh autotest.sh mark.sh" > "$add_arguments1"
echo "lab1 z1234567 1" > "$submit_arguments1"

touch solution.sh
touch autotest.sh
touch mark.sh
touch ass1.sh

set -- $(cat "$add_arguments1")
"$current_path/give-add" "$@" > "$pro_output"
set -- $(cat "$submit_arguments1")
"$give_file" "$@" 2>> "$pro_output"


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

rm "$exp_output" "$pro_output" "$add_arguments1" "$submit_arguments1"
rm "$current_path/solution.sh" "$current_path/autotest.sh" "$current_path/mark.sh" "$current_path/ass1.sh"

##### test 4 #######
num=$((num + 1))
exp_output=$(mktemp)
pro_output=$(mktemp)
add_arguments1=$(mktemp)
submit_arguments1=$(mktemp)

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

echo "directory .give created\nassignment lab1 created\nno submissions for z1234567" > "$exp_output"
echo "lab1 solution.sh autotest.sh mark.sh" > "$add_arguments1"
echo "lab1 z1234567 1" > "$submit_arguments1"

touch solution.sh
touch autotest.sh
touch mark.sh
touch ass1.sh

set -- $(cat "$add_arguments1")
"$current_path/give-add" "$@" > "$pro_output"
mkdir .give/.ass/lab1/z1234567
set -- $(cat "$submit_arguments1")
"$give_file" "$@" 2>> "$pro_output"

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

rm "$exp_output" "$pro_output" "$add_arguments1" "$submit_arguments1"
rm "$current_path/solution.sh" "$current_path/autotest.sh" "$current_path/mark.sh" "$current_path/ass1.sh"