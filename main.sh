./hosts_selector.sh
awk 'END{print NR}' switches > no_switches
read no_switches < no_switches
for m in $(seq 1 $no_switches)
do
cat switches | awk NR==$m > current_selected_switch
read current_selected_switch < current_selected_switch
./compare_files.sh $current_selected_switch
./interface_down.sh
done
cp selected_interface selected_interface_up
#rm selected_interface
