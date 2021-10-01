tenant_name = "test2"
applications = [
    {
        name: "app1"
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
    },
    {
        name: "app2"
        virtualAddresses: ["10.1.1.101"]
        virtualPort: 8080
        pool_members: [
            {
                serverAddresses: ["10.1.2.100", "10.1.2.101"]
                servicePort: 8082
            },
            {
                serverAddresses: ["10.1.2.100", "10.1.2.101"]
                servicePort: 8083
            }
        ]
    }
]