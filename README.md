# LabVIEW Sift Client Library
## Overview
The LabVIEW Sift Client Plugin enables interaction with the Sift application. This plugin provides tools for streaming data to Sift to leveraging its powerful visualization and data analysis capabilities.

## Key Features
* Data Streaming: Stream real-time data from LabVIEW to Sift for visualization and analysis.
* Cross-Platform Support: Compatible with Windows and Linux systems.
* Simple Integration: Designed to integrate into existing LabVIEW projects with minimal setup.

## Requirements
* LabVIEW Version: 2024 or later (If an older version of LabVIEW is desired please reach out to engineering@siftstack.com)
* Operating System: Windows and Linux

## Example
![{272E378E-70EE-4902-99A5-2923D2763256}](https://github.com/user-attachments/assets/f273ebeb-de6d-46f1-a0c2-a12644ce387b)
The example initializes the client, starts the local proxy which enables high throughpout streaming over gRPC, then streams data before finally stopping the local proxy.

See the other [Examples](/src/Sift/Examples) included in the plugin for more details.


## Contact
For questions, issues, or feature requests, please contact engineering@siftstack.com or open a GitHub Issue ticket.
