function ktxt() {kubectl config use $1}

function patch-deployment { 
kubectl patch deployments.apps ${1} --patch-file <(cat <<EOF
  {
    "spec": {
      "template":  {
        "spec": {
          "containers": [
            {
              "name": "${1}",
              "image": "${2}"
            }
          ]
        }
      }
    }
  }
EOF
)
}

function read-logs () {
  local PROJECT=$1
  local SEGMENT_ID="$(echo $2 | sed -r 's#/#-#')"
  local FLAGS=("${*[@]:3}")
  gcloud logging read "resource.type=\"k8s_container\" AND \
     resource.labels.project_id=\"redshred-${PROJECT}\" AND \
     resource.labels.namespace_name=\"reads\" AND \
     labels.k8s-pod/redshred/segment-id=\"${SEGMENT_ID}\"" \
     --format 'value(textPayload)' $FLAGS | tac
}

function tag-latest-image() {
  IMAGE_NAME=$1
  LATEST_TAG=$(
    gcloud container images list-tags --limit=1 gcr.io/redshred-staging/${IMAGE_NAME} | tail -n1 | sed -r "s/\s+/ /" - | cut -d\  -f2 | cut -d, -f1
  )
  echo Adding tag to newest image: "${IMAGE_NAME}:${LATEST_TAG}"
  if [[ "$2" ]]
  then
  	gcloud container images add-tag "gcr.io/redshred-staging/$IMAGE_NAME:$LATEST_TAG" "gcr.io/redshred-staging/$IMAGE_NAME:$2" -q
  else
  	DATESTAMP=$(TZ='America/New_York' date +'%Y%m%d-%H%M')
     	gcloud container images add-tag "gcr.io/redshred-staging/$IMAGE_NAME:$LATEST_TAG" "gcr.io/redshred-staging/$IMAGE_NAME:$DATESTAMP" -q
  fi	
}


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

firstpod() (kubectl get pods -l app=$1 -o jsonpath='{.items[0].metadata.name}')

last-docker-image () {
	docker image ls --format='{{.Repository}}:{{.Tag}}' "gcr.io/redshred-staging/$1" | head -n1
}


dolla() (_code=$(echo $@ | sed -r 's/^\s*\$\s*//') && eval $_code)
