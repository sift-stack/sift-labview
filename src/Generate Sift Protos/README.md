This LabVIEW project is used to generate/update the Sift protos.

## Instructions

$REPO_DIR is the path to this repo

$PROTOBUF_DIR is the path where you extract the protobuf release in step 2.

1. Install LabVIEW gRPC libraries: https://github.com/ni/grpc-labview/releases
2. Download and extract google protobufs to $PROTOBUF_DIR
   * https://github.com/protocolbuffers/protobuf/releases
   * Any platform is fine, we just need the proto files.
3. Download the googleapis repo: https://github.com/googleapis/googleapis/tree/master
3. Open LabVIEW -> Tools -> gRPC -> Code Generator

Fill in the dialog with the following:

Proto File Path:
$REPO_DIR/protos/sift_proxy/v1/labview.proto
$REPO_DIR/protos/sift_proxy/v1/control.proto

Import Paths:
$PROTOBUFS_DIR/include

Target Project:
Generate Sift Protos (Project in this repo)

Generated Library Name:
SiftProxy

Generate:
gRPC Client 

Click Run

Copy the SiftProxy_client folder to  labview/generated directory. (Might not be nessecary)