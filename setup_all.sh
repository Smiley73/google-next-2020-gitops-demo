#!/bin/bash

set -euo pipefail

./setup_gke.sh
./setup_kcc.sh
./setup_eunomia.sh
