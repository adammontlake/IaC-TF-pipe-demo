#!/bin/bash

##############################################################################################################
### Self hosted runners setup script                                                                       ###                 
### Note:                                                                                                  ###
### 1. This script was tested on Ubuntu 22.04 LTS - for any other OS, please adjust the script accordingly ###
### 2. This script is intended to be run as a custom script extension on a Linux VM                        ###
### 3. Script assumes run-as root                                                                          ###
### 4. The script will install the following:                                                              ###
###    a. Root CA certificate (GitHub server CA) + Terraform binary                                        ###
###    b. GitHub Self Hosted Runner pre-requisites                                                         ###
###    c. GitHub Self Hosted Runner                                                                        ###
### 5. The script will download the following from Azure Blob Storage:                                     ###
###    a. Root CA certificate (GitHub server CA)                                                           ###
###    b. Terraform binary                                                                                 ###
### 6. The script will get the following from Azure Key Vault:                                             ###
###    a. GitHub PAT token                                                                                 ###
### 7. The script will get the following from GitHub:                                                      ###
###    a. Runner registration token                                                                        ###
###    b. Runner binary                                                                                    ###
##############################################################################################################


log_pth="/var/log"
log_file="${log_pth}/cse_runner_setup_log"

# Time format for logging purposes
get_time () { time=$(date '+%d/%m/%Y %H:%M:%S') ; }

# This function will log the input to the log file
emit(){
get_time
if [ -n "${1}" ]; then         
    IN="${1}"
    sudo echo "<${time}> ${IN}" >> ${log_file}
else
    while read IN               
    do
        sudo echo "<${time}> ${IN}" >> ${log_file}
    done
fi
}

### If you are connecting to a certificate signed by a well knwon (trusted) CA, you can skip the certificate part and only download Terraform
# Install Root CA (GitHub server CA) + Terraform 
ca_cert_name="test_github_ca.crt"
terraform_binary="terraform"
blob_name="teststorage"
container_name=dependencies
binary_folder="/usr/local/bin"
# Download CA cert from blob storage
curl -o $ca_cert_name https://$blob_name.blob.core.windows.net/$container_name/$ca_cert_name
# Download Terraform binary
curl -o $terraform_binary https://$blob_name.blob.core.windows.net/$container_name/$terraform_binary

# Install root CA into trusted root
emit "Import CA certificate"
cp $ca_cert_name /usr/local/share/ca-certificates
update-ca-certificates

# Install Terraform
cp $terraform_binary $binary_folder
chmod +x "${binary_folder}/${terraform_binary}"

### Get GH PAT token from Azure KV ###
# Token permissions: read:org, manage_runners:org, repo
# Get managed identity token to use in KV access
mi_token_raw=$(curl -H Metadata:true \
  'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net') 
mi_token_regex='access_token\":\"([A-z0-9.\-]+)\"'
# Extract token from response
if [[ $mi_token_raw =~ $mi_token_regex ]]; then   mi_token="${BASH_REMATCH[1]}"; else  emit "no match found for: mi_token_regex"; fi

# Get Secret from KV
vault_name=GitHub-vault
secret_name=GitHub-PAT
vault_gh_secret_raw=$(curl -H "Authorization: Bearer $mi_token" \
  "https://$vault_name.vault.azure.net/secrets/$secret_name?api-version=2016-10-01") 
gh_secret_regex='value\":\"([A-z0-9.\-\_]+)\"'

# Extract only secret value from response
if [[ $vault_gh_secret_raw =~ $gh_secret_regex ]]; then   gh_token="${BASH_REMATCH[1]}"; else  emit "no match found for: gh_secret_regex"; fi
export GH_TOKEN=$gh_token

### GitHub Self Hosted Runner pre-requisites ###
# Get a new registration token for registering the runner
server_url="private.github.com"
org_name="org"
repo_name="repo"
repo_path="$org_name/$repo_name"
server_api_url="api.$server_url"
registration_token_raw=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://$server_api_url/repos/$repo_path/actions/runners/registration-token) 

# Get binary downloading token from GitHub server 
download_details_raw=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  https://$server_api_url/orgs/$org_name/actions/runners/downloads) 

# Regex definition for download_url, download_filename,download_token and registration_token
download_url_regex='download_url\":\ \"(https://[-[:alnum:]/_:.]+linux-x64[-[:alnum:]/.]+)\"'
download_filename_regex='filename\":\ \"([-[:alnum:].]+linux-x64[-[:alnum:].]+.gz)\"'
download_token_regex='temp_download_token\":\ \"([A-z0-9.\n\-]+)"'
registration_token_regex='token\":\ \"([A-z0-9.\-]+)\"'

# Extract data from raw response 
if [[ $download_details_raw =~ $download_url_regex ]]; then   download_url="${BASH_REMATCH[1]}"; else  emit "no match found for: download_url_regex"; fi
if [[ $download_details_raw =~ $download_filename_regex ]]; then   filename="${BASH_REMATCH[1]}"; else  emit "no match found for: download_filename_regex"; fi
if [[ $download_details_raw =~ $download_token_regex ]]; then   download_token="${BASH_REMATCH[1]}"; else  emit "no match found for: download_token_regex"; fi
if [[ $registration_token_raw =~ $registration_token_regex ]]; then   registration_token="${BASH_REMATCH[1]}"; else  emit "no match found for: registration_token_regex"; fi

# Download agent binary
emit "Download binary"
curl -L \
  -o $filename \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $download_token" \
  $download_url

### Install/config Runner
mkdir gh_agent 
mv $filename gh_agent 
cd gh_agent

# Extract the installer
tar xzf ./$filename

# Create the runner and start the configuration experience
emit "Configure service"
repo_path="org/repo"
export RUNNER_ALLOW_RUNASROOT=1
./config.sh --url https://$server_url/$repo_path --token $registration_token --unattended  | emit #--ephemeral 

# Install the agent as a service
emit "Install service"
./svc.sh install | emit
emit "Start service"
./svc.sh start | emit

# Remove the GH token for security
emit "Unset GH token"
unset GH_TOKEN | emit
