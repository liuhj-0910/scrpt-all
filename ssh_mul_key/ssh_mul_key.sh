#!/bin/bash  

SSH_PATH=~/.ssh

rm -rf ~/sshbak && mkdir -p ~/sshbak && mv ${SSH_PATH}/* ~/sshbak

rm -rf config id_rsa*

M=0
PARAM_LIST=()
DEFAULT_EMAIL=
while [[ $# -gt 0 ]]; do  
  key="$1"  
  case $key in  
    -k|--key)
	  M=`expr $M + 1`
	  PARAM_LIST+=("$2:$3:$4")
      shift # past argument  
      shift # past suffix  
	  shift # past host 
	  shift # past email 
      ;;
	--email)
	  DEFAULT_EMAIL=$2
      shift # past argument  
      shift # past email  
      ;;
    *)
      shift # past argument  
      ;;  
  esac  
done

echo $DEFAULT_EMAIL
ssh-keygen -f "id_rsa" -N ""  -C "${DEFAULT_EMAIL}"

for param in ${PARAM_LIST[*]} ; do
  suffix=`echo $param | cut -d ":" -f 1`
  email=`echo $param | cut -d ":" -f 3`
  echo $suffix
  echo $email
  
  ssh-keygen -f "id_rsa_${suffix}" -N ""  -C "${email}"
done


cat << EOF > config
Host *
HostkeyAlgorithms +ssh-rsa
PubkeyAcceptedAlgorithms +ssh-rsa
EOF


for param in ${PARAM_LIST[*]} ; do
  suffix=`echo $param | cut -d ":" -f 1`
  host=`echo $param | cut -d ":" -f 2`
  echo $suffix
  echo $host
  
cat << EOF >> config

# $suffix
Host $host
HostName $host
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_$suffix
User liuhj
EOF

done

mv config ${SSH_PATH}
mv id_rsa* ${SSH_PATH}




