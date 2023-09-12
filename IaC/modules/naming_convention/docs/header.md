This module returns a resource name based on the naming convention standards specified in the HLD.

Note: please validate which input is necessary based on the required resource name
For example:
1. For type = "resource_group" the necessary parameters are:
    i. service_name
    ii. environment
2. For type = "network_security_group" the necessary parameters are:
    i. nsg_scope
    ii. nsg_resource