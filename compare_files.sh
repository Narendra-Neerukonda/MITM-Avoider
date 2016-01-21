cat $1 | awk 'END{print NR}' > no_selected_hosts
cat standard_hosts | awk 'END{print NR}' > no_standard_hosts
read no_selected_hosts < no_selected_hosts
read no_standard_hosts < no_standard_hosts
for i in $(seq 1 $no_selected_hosts)
do
cat $1 | awk NR==$i > selected_line
cat selected_line | awk '{print $1}' > selected_mac
cat selected_line | awk '{print $2}' > selected_ips
read selected_mac < selected_mac
read selected_ips < selected_ips
echo $selected_mac
echo $selected_ips
k=0
for j in $(seq 1 $no_standard_hosts)
do
cat standard_hosts | awk NR==$j > selected_standard_line
cat selected_standard_line | awk '{print $1}' > interface
cat selected_standard_line | awk '{print $2}' > macs
cat selected_standard_line | awk '{print $3}' > ips
read interface < interface
read mac < macs
read ips < ips
 
 
echo $selected_mac $mac
echo $selected_ips $ips
if [ $selected_mac == $mac ]
then
if [ $selected_ips == $ips ]
then
echo a
else
echo $interface >> selected_interface
fi
else
let k=k+1
fi
done
if [ $j = $k ]
then
echo $1-eth1 >>  selected_interface
fi
done
unset i
unset j
unset k

rm no_selected_hosts
rm no_standard_hosts
rm selected_line
rm selected_mac
rm selected_ips
rm interface
rm macs
rm ips
rm selected_standard_line

