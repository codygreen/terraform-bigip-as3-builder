tenant_name = "test1"
applications_http = [
    {
        name: "test"
        virtualAddresses: ["10.1.1.100"]
        virtualPort: 8080
        pool_members: [
            {
                serverAddresses: ["10.1.2.100", "10.1.2.101"]
                servicePort: 8080
            },
            {
                serverAddresses: ["10.1.2.100", "10.1.2.101"]
                servicePort: 8081
            }
        ]
    }
]
applications_https = []