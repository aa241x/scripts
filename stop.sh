echo "stopping the ros core and all nodes"

# bash script to stop the currently running roscore given the process id of the roscore
kill `cat ~/pid.txt`
rm ~/pid.txt