#!/bin/bash

#
# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -e

# Create SA to be used by terraform and enable user account to impersonate the service account

gcloud iam service-accounts create "${TERRAFORM_SA}" \
    --description="Used by Terraform to deploy GCP resources" \
    --display-name="Terraform Service Account"

gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member="serviceAccount:${TERRAFORM_SA}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role="roles/owner"

gcloud iam service-accounts add-iam-policy-binding \
    "${TERRAFORM_SA}@${PROJECT_ID}.iam.gserviceaccount.com"    \
    --member="user:${ACCOUNT}" \
    --role="roles/iam.serviceAccountUser"

gcloud iam service-accounts add-iam-policy-binding \
    "${TERRAFORM_SA}@${PROJECT_ID}.iam.gserviceaccount.com" \
    --member="user:${ACCOUNT}" \
    --role="roles/iam.serviceAccountTokenCreator"
