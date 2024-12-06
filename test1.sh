#!/bin/dash
#
# COMP9044 Assignment 01 - give
#
# give-add test
#
# Author: Aron (z5494376@ad.unsw.edu.au)
#
# Written: 3/7/2024
#
# test list:
# 1. test1: no arguments
# 2. test2: wrong arguments
# 3. test3: created successfully
#
# check tool:
# cat "$pro_output"
# echo "#############"
# cat "$exp_output"

##### give name ############
give_dir=".give"
give_order="give-add"

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

# check tool:
#
echo "###### test$num ############"
echo "Produced stdout or stderr:"
cat "$pro_output"
echo "##########################"
echo "Expected stdout or stderr:"
cat "$exp_output"
echo "##########################"

echo "usage: $give_order <assignment> <solution> <autotests> <automarking>" > "$exp_output"
"$give_file" 2> "$pro_output"

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

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

echo "$give_order: invalid automarking: abcd?" > "$exp_output"
echo "lab1 solution.sh autotest.sh abcd?" > "$arguments"


if test -s "$arguments"; then
    set -- $(cat "$arguments")
    "$give_file" "$@" 2> "$pro_output"
else
    "$give_file" 2> "$pro_output"
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


##### test 3 #######
num=$((num + 1))
exp_output=$(mktemp)
pro_output=$(mktemp)
arguments=$(mktemp)

if test -d "$give_dir"; then
    rm -rf "$give_dir"
fi

echo "directory .give created\nassignment lab1 created" > "$exp_output"
echo "lab1 solution.sh autotest.sh mark.sh" > "$arguments"
touch solution.sh
touch autotest.sh
touch mark.sh

if test -s "$arguments"; then
    set -- $(cat "$arguments")
    "$give_file" "$@" > "$pro_output"
else
    "$give_file" > "$pro_output"
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
    # cd ass
    if ! cd .give/.ass/lab1; then
        echo "test$num failed."
        exit 1
    fi
    # cd solution
    if ! cd _solution; then
        echo "test$num failed."
        exit 1
    fi
    # find solution
    if find . -maxdepth 1 -type f -name "solution.sh" | read  -r file; then
        :
    else
        echo "test$num failed."
        exit 1
    fi  

    # cd autotest
    if ! cd ../_autotest; then
        echo "test$num failed."
        exit 1
    fi
    # find autotest
    if find . -maxdepth 1 -type f -name "autotest.sh" | read -r file; then
        :
    else
        echo "test$num failed."
        exit 1
    fi  

    #cd automark
    if ! cd ../_automark; then
        echo "test$num failed."
        exit 1
    fi
    # find automark
    if find . -maxdepth 1 -type f  -name "mark.sh" | read -r file; then
        :
    else
        echo "test$num failed."
        exit 1
    fi  

    echo "test$num passed."
else
    echo "test$num failed."
fi

rm "$exp_output" "$pro_output" "$arguments"
rm  "$current_path/solution.sh" "$current_path/autotest.sh" "$current_path/mark.sh"