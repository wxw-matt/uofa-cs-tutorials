#!/usr/bin/env bash
do_oop () {
  # making directories
  local stu_id=$1
  local yea_id=$2
  local sem_id=$3
  local cou_id=$4
  for i in 01 02 03 04 05 06 07
  do
    echo "Creating practical directory: practical-$i"
    mkdir -p $stu_id/$yea_id/$sem_id/$cou_id/practical-$i
    echo "Creating workshop directory: workshop-$i"
    mkdir -p $stu_id/$yea_id/$sem_id/$cou_id/workshop-$i
  done
}

do_adds () {
  # making directories
  local stu_id=$1
  local yea_id=$2
  local sem_id=$3
  local cou_id=$4
  for i in 1 2 3 4
  do
    echo "Creating assignment directory: assignment $i"
    mkdir -p $stu_id/$yea_id/$sem_id/$cou_id/"assignment $i"
  done
}

if [ ! -x "$(command -v svn)" ]; then
  sudo apt install -y subversion
fi

echo "### Ctrl+C to stop this script! ###"

read -p "Enter Your Student Id (ex.: a1xxxxxx): "  student_id
echo "Your student id is  $student_id!"

year=2020
semester_name=""
echo "(1) $year Semester 1"
echo "(2) $year Semester 2"

read -p "Choose your semester: 1 or 2: "  semester_id
case $semester_id in
  1)
    semester_name="s1"
    ;;

  2)
    semester_name="s2"
    ;;

  *)
    echo "Wrong semester, script is exiting ..."
    exit 1
    ;;
esac
echo

course_name=""
echo "(1) OOP"
echo "(2) ADDS"

read -p "Choose your course: 1 or 2: "  course_id
case $course_id in
  1)
    course_name="oop"
    ;;

  2)
    course_name="adds"
    ;;

  *)
    echo "Wrong course, script is exiting ..."
    exit 1
    ;;
esac


echo "Checkout svn repository for $student_id studying $course_name \
in $year $semester_name ..."
sleep 0.5
# svn co --username $student_id https://version-control.adelaide.edu.au/svn/$student_id
case $course_name in
  "oop")
    do_oop $student_id $year $semester_name $course_name
    ;;
  "adds")
    do_adds $student_id $year $semester_name $course_name

    ;;
esac

echo
echo "Directories have been initialized already."
echo
echo "Please follow the instructions to commit:"
echo "# Go to your svn root directory:"
echo cd $student_id
echo "# Check files/directories status:"
echo svn st
echo "# Commit your changes:"
echo svn ci . -m'"Creating directories"'

