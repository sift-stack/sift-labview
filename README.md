# LabVIEW Sift Client Library
## Overview
The LabVIEW Sift Client Plugin enables interaction with the Sift application. This plugin provides tools for streaming data to Sift to leveraging its powerful visualization and data analysis capabilities.

## Key Features
* Stream real-time data from LabVIEW to Sift (via gRPC) for visualization and analysis.
* Sift Run and Ingestion Config creation.
* Compatible with all operating systems.
* Designed to integrate into existing LabVIEW projects with minimal setup.

## Requirements
* LabVIEW Version: 2024 or later (If an older version of LabVIEW is desired please reach out to engineering@siftstack.com)

## Example
![image](https://github.com/user-attachments/assets/07720331-e416-4c1d-8ff2-35d5290c8bb6)
The example initializes the client, connects to the local proxy which enables high throughpout streaming over gRPC, then streams data before disconnecting from the local proxy.

See the other [Examples](/src/Sift/Examples) included in the plugin for more details.

## Installation
Grab the .vip from the [Releases](https://github.com/sift-stack/sift-labview/releases) page and install with the VI Package Manager.

For RT Linux: Copy over the sift_proxy binary that comes with the package to `/home/lvuser/Sift` and run `sudo chmod +x /home/lvuser/Sift/sift_proxy`

## Contact
For questions, issues, or feature requests, please contact engineering@siftstack.com or open a GitHub Issue ticket.
