cat selected_interface | awk 'END{print NR}' > no_interfaces
read no_interfaces < no_interfaces
for l in $(seq 1 $no_interfaces)
do
cat selected_interface | awk NR==$l > current_selected_interface
read current_selected_interface < current_selected_interface
ifconfig $current_selected_interface down
done
rm current_selected_interface
rm no_interfaces
cp selected_interface > selected_interface_up
