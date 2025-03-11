gcloud beta container --project "cr25-spotlight" clusters create "demo-2" \
    --zone "us-west4-b" --tier "standard" --no-enable-basic-auth \
    --cluster-version "1.32.2-gke.1182000" --release-channel "rapid" \
    --machine-type "e2-standard-4" --image-type "COS_CONTAINERD" --disk-type "pd-balanced" \
    --disk-size "100" --metadata disable-legacy-endpoints=true \
    --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
    --num-nodes "3" --logging=SYSTEM,WORKLOAD,API_SERVER,SCHEDULER,CONTROLLER_MANAGER \
    --monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,DAEMONSET,HPA,JOBSET,CADVISOR,KUBELET,DCGM,API_SERVER,SCHEDULER,CONTROLLER_MANAGER \
    --enable-ip-alias --network "projects/cr25-spotlight/global/networks/default" \
    --subnetwork "projects/cr25-spotlight/regions/us-west4/subnetworks/default" \
    --no-enable-intra-node-visibility --default-max-pods-per-node "110" --enable-autoscaling \
    --min-nodes "1" --max-nodes "3" --location-policy "BALANCED" --enable-dns-access \
    --enable-ip-access --security-posture=standard \
    --workload-vulnerability-scanning=disabled --enable-dataplane-v2 --enable-autoprovisioning \
    --enable-dataplane-v2-metrics --enable-dataplane-v2-flow-observability \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing,NodeLocalDNS,GcePersistentDiskCsiDriver,GcsFuseCsiDriver \
    --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 \
    --max-unavailable-upgrade 0 --binauthz-evaluation-mode=DISABLED --enable-managed-prometheus \
    --workload-pool "cr25-spotlight.svc.id.goog" --enable-shielded-nodes \
    --enable-image-streaming --node-locations "us-west4-b"

    gcloud beta container --project "cr25-spotlight" clusters create "demo2-cluster" --region "us-central1" --tier "standard" --no-enable-basic-auth --cluster-version "1.32.2-gke.1297000" --release-channel "rapid" --machine-type "e2-medium" --image-type "COS_CONTAINERD" --disk-type "pd-balanced" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "3" --logging=SYSTEM,WORKLOAD,API_SERVER,SCHEDULER,CONTROLLER_MANAGER --monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,DAEMONSET,HPA,JOBSET,CADVISOR,KUBELET,DCGM,API_SERVER,SCHEDULER,CONTROLLER_MANAGER --enable-ip-alias --network "projects/cr25-spotlight/global/networks/default" --subnetwork "projects/cr25-spotlight/regions/us-central1/subnetworks/default" --no-enable-intra-node-visibility --default-max-pods-per-node "110" --enable-ip-access --security-posture=standard --workload-vulnerability-scanning=disabled --enable-dataplane-v2 --enable-dataplane-v2-metrics --enable-dataplane-v2-flow-observability --no-enable-google-cloud-access --addons HorizontalPodAutoscaling,HttpLoadBalancing,NodeLocalDNS,GcePersistentDiskCsiDriver,GcpFilestoreCsiDriver --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --binauthz-evaluation-mode=DISABLED --enable-autoprovisioning --min-cpu 1 --max-cpu 10 --min-memory 1 --max-memory 64 --enable-autoprovisioning-autorepair --enable-autoprovisioning-autoupgrade --autoprovisioning-max-surge-upgrade 1 --autoprovisioning-max-unavailable-upgrade 0 --enable-managed-prometheus --workload-pool "cr25-spotlight.svc.id.goog" --enable-shielded-nodes --shielded-integrity-monitoring --no-shielded-secure-boot --enable-image-streaming


gcloud container node-pools create a100-mig-np \
    --cluster=a100mig-demo \
    --location=us-central1-f \
    --accelerator type=nvidia-tesla-a100,count=1,gpu-partition-size=1g.5gb,gpu-driver-version=latest  \
    --machine-type=a2-highgpu-1g  \
    --enable-autoscaling  \
    --num-nodes=1   \
    --total-max-nodes 3  \
    --location-policy=ANY  \
    --reservation-affinity=any  \
    --enable-gvnic \
    --no-enable-autorepair


export API_KEY=AIzaSyDu6dD7oKN3FvgfSlCDsuflON0HYGBBSWQ
export BASE_URL=https://gkerecommender.googleapis.com  

mock-gcloud container ai recommender models list

mock-gcloud container ai recommender model-servers list \
--model=meta-llama/Meta-Llama-3-8B

mock-gcloud container ai recommender model-server-versions list \
--model=meta-llama/Meta-Llama-3-8B \
--model-server=vllm

mock-gcloud container ai recommender accelerators list \
--model=meta-llama/Meta-Llama-3-8B \
--model-server=vllm \
--model-server-version=v0.7.2

mock-gcloud container ai recommender manifests create --model=meta-llama/Meta-Llama-3-8B \
--model-server=vllm  \
--model-server-version=v0.7.2 \
--accelerator-type=nvidia-l4 \
--target-ntpot-milliseconds=200