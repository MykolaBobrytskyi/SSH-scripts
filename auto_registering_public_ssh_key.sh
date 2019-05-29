eval `ssh-agent -s`
ssh-add ___path_to_private_key

# "144.76.180.159"  - timeouted
# failed auth: "144.76.180.147" "144.76.180.151" "148.251.203.115"

ip_pool="some_random_IP's_listed"

for server in $ip_pool
do
   :
   echo "Processing $server"
   #eval "cat DevOps_key.pub | ssh rails@$server \"mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys\""
   eval "cat DevOps_key.pub | ssh -i /home/ubuntu/workspace/other2 -oStrictHostKeyChecking=no rails@$server \"mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys\""
done


for server in $ip_pool
do
   :
   echo "Processing $server"
   #eval "cat DevOps_key.pub | ssh rails@$server \"mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys\""
   eval "cat DevOps_key.pub | ssh -i /home/ubuntu/workspace/other2 -oStrictHostKeyChecking=no app@$server \"mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys\""
done
