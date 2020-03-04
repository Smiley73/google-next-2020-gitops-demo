# Caution

You need a GCP project and must have owner permissions on it to proceed with this demo.
Make sure you set the environment correctly as described below.

Also ... no warranty or help whatsever on this. It's purely for reference.

# Configure the environment

```
export URI="https://github.com/Smiley73/google-next-2020-gitops-demo.git"
export REF="master"
export PROJECT_ID=your-gcp-project-id
```

# Set up the GKE cluster, Config Connector, and Eunomia

```
./scripts/setup_all.sh
```

If any of the components fail or you want to run them separately, just execute the appropriate `setup_xxx.sh` script.

# Cleanup

Simply run the below script to remove the demo environment again.
```
./scripts/cleanup.sh
```
