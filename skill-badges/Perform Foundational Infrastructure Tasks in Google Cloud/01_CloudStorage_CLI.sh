# Cloud Storage: Qwik Start - CLI/SDK

## Create a bucket

## Upload an object into your bucket
# First, download this image to a temporary instance (ada.jpg) in Cloud Shell:
curl https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg --output ada.jpg

# gsutil cp command to upload the image from the location where you saved it to the bucket
gsutil cp ada.jpg gs://YOUR-BUCKET-NAME

# Now remove the downloaded image:
rm ada.jpg


## Download an object from your bucket
gsutil cp -r gs://YOUR-BUCKET-NAME/ada.jpg .


## Copy an object to a folder in the bucket
gsutil cp gs://YOUR-BUCKET-NAME/ada.jpg gs://YOUR-BUCKET-NAME/image-folder/


## List contents of a bucket or folder
gsutil ls gs://YOUR-BUCKET-NAME


## List details for an object
gsutil ls -l gs://YOUR-BUCKET-NAME/ada.jpg


## Make your object publicly accessible
# gsutil acl ch command to grant all users read permission for the object stored in your bucket
gsutil acl ch -u AllUsers:R gs://YOUR-BUCKET-NAME/ada.jpg


## Remove public access
gsutil acl ch -d AllUsers gs://YOUR-BUCKET-NAME/ada.jpg


## Delete objects
gsutil rm gs://YOUR-BUCKET-NAME/ada.jpg
