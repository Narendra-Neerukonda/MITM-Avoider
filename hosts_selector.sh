ifconfig | grep eth1 | awk '{print $1}' | cut -c 1-2 > switches
awk 'END{print NR}' switches > no_switches
read no_switches < no_switches
for j in $(seq 1 $no_switches)
do
  cat switches | awk NR==$j > selected_switch
  read selected_switch < selected_switch
  rm $selected_switch
  ovs-ofctl dump-flows $selected_switch >> flows
  cat flows | grep arp |grep in_port=1 > selected_flows 
  cat selected_flows | awk '{print $8}' > arp_flows
  awk 'END{print NR}' arp_flows | cat > arp_lines
  read n < arp_lines

  cat arp_flows | cut -c 49-65 > macs 
  cat arp_flows | cut -c 100-107 > ips


for i in $(seq 1 $n)
do
	cat macs | awk NR==$i > mac_var
	cat ips | awk NR==$i > ips_var
	read b < mac_var
	read c < ips_var
	echo $b $c >> $selected_switch
done
done

unset n
unset i
unset mac_var
unset ips_var
rm selected_flows
rm arp_flows
rm arp_lines
rm macs
rm ips
rm mac_var
rm ips_var
rm flows
rm selected_switch
rm no_switches
