# Monitoring

To ensure system reliability, security, and normal operating procedure we implemented a continuous monitoring solution. 

### [cAdvisor](https://github.com/google/cadvisor)

See a live feed of our production cAdvisor monitoring -- http://cadvisor.treeview.io:8080/

![cadvisor EPA](https://cloud.githubusercontent.com/assets/16209237/11935505/2d603a3c-a7d6-11e5-9ce9-dfa30b15107b.png)

The cAdvisor tool allows us to seamlessly review and analyze our EC2 instance machine performance, as well as dive into the container specific metrics. The information is presented in a simple but efficient html format that can be accessed anytime and anywhere. Insights or warning can be discovered through useful graphs and metrics on memory usage, cpu usage, throughput, and processes. Container specific metrics are valuable to review anomalies in the exact service, reducing debugging time, and allowing for service specific optimizations. 

### [Prometheus](http://prometheus.io/)

Prometheus is used as an interface for querying and charting the real-time metrics provided by cAdvisor. We're also using its alerting functionality to publish alerts to its Alert Manager component, which then pushes the alerts to the a slack channel through a custom webhook.

A small snippit of a report is shown below.

![prometheus_v2](https://cloud.githubusercontent.com/assets/16209237/11935668/1a9ed632-a7d7-11e5-96ab-56412accf422.png)

All administrative access to the environment is performed over secure VPN tunnel.  A VPC provides isolation of the instances from neighboring environments in the AWS IaaS. We apply SSL-by-default, all servers are protected by a valid SSL certificate, and HTTP requests to the site are redirected to SSL automatically.

![physical_deployment](https://cloud.githubusercontent.com/assets/16209237/11934954/06fd3b68-a7d3-11e5-8dbe-1b568917e655.png)

### [slack](https://slack.com/)

We used slack integrations to keep a consistent eye on any activity with Github, Prometheus, and Jenkins. GitHub pushes and pull requests could be immediately observed in the slack app. Also, using a Jenkins plugin we were able to get immediate notifications on any deployments being orchestrated by the Jenkins CI. This monitoring kept the team in synch with what was being released to the different environments and if there were any build, test, or deployment failures. 
