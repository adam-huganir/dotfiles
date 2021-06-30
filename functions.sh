


# Get the CPU utilization (total) as a percentage (glances server must be running
_get_cpu () {
	python3 -c "import xmlrpc.client, json; print(f'{ json.loads(xmlrpc.client.ServerProxy(\"http://localhost:61209\").getall())[\"quicklook\"][\"cpu\"]/100.0:4.0%}')"
}

_get_ram () {
        python3 -c "import xmlrpc.client, json; print(f'{ json.loads(xmlrpc.client.ServerProxy(\"http://localhost:61209\").getall())[\"quicklook\"][\"mem\"]/100.0:4.0%}')"
}

_get_cpu_mem () {
        python3 -c "import xmlrpc.client, json; _ = json.loads(xmlrpc.client.ServerProxy(\"http://localhost:61209\").getAll()); print(f\"MEM {_['quicklook']['mem']/100.0:4.0%} | CPU {_['quicklook']['cpu']/100.0:4.0%}\")"
}


# alias for basename->pwd (this could just be an alias, but I'm already in this file)
pwdbasename() { basename $(pwd) } 

# Run an ssh loop to make sure you remain connected when possible
ssh-loop() { while [ 1 ] ; do ssh $1 ; done}

k8s-first-container() {
 arr=( $(kubectl get pods  --no-headers -l "app=$1" | cut -d\  -f1 | xargs echo -n) ) ; 
 echo "${arr[1]}";
}

lanscan () (nmap -sP $(ifconfig enx4865ee136404 | grep -o -P '(?<=inet )(\d+\.)+')0/24 | grep -oP '(?<=Nmap scan report for ).*')
