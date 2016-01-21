cat selected_interface_up | awk 'END{print NR}' > no_interfaces
sleep 10
for n in $(seq 1 $no_interfaces)
do
cat selected_interface_up |awk NR==$n > interface_on
read interface_on < interface_on
echo $interface_on
ifconfig $interface_on up
done
rm selected_interface_up
rm no_interfaces

