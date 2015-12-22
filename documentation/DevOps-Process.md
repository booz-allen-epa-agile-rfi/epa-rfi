# Booz Allen Hamilton, Agile Delivery Services DevOps Workflow


![all](https://cloud.githubusercontent.com/assets/16209237/11881947/cedf4bf2-a4d7-11e5-9fa8-d6ca22ca120f.png)


This project uses Booz Allen's agile and DevOps practices from Development to Operations and Operations back to Development. All of the information on this page reflects how our DevOps code works for the the prototype we built for the response to this RFI.

Our definition of DevOps is, it is a set of practices intended to reduce the time between committing a change to the system we're building, maintaining or operating, and the change being placed into normal production, while ensuring high quality. It is a catchall term that can cover several meanings, including; having development and operations continuously communicate to each other; allowing development teams to deploy to production automatically using well defined and proven practices; and having our development team be the first responders when an error is discovered in production. Although, this effort was a response to an RFI, we established our DevOps cultural and technical framework in sprint zero and continued to evolve it though out the challenge. The source code for our DevOps scripts (or Infrastructure as code) can be found in this git hub at the following URL:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/tree/master/bin/jenkins

Check out the live jenkins server at https://jenkins.treeview.io/

* Continuous Development
* Configuration Management
* Continuous Integration
* Automated Testing
* Continuous Deployment 
* Continuous Delivery

**Production Environment :** is the live system

## Continuous Development and Configuration Management:

![1](https://cloud.githubusercontent.com/assets/16209237/11881933/c247b988-a4d7-11e5-9cf2-9eeffbddd57b.png)

**Continuous Development :** We use agile development practices which provides iterative and continuous development capabilities to our engineering team. To us, continuous development is building a system in small chunks. For for this prototype, we defined the scope by [User Stories] (https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/User-Stories.md). These stories are developed over single or multiple 4 hour sprints. At sprint planning sessions, we decomposed the scoped user stories into smaller pieces (sub-stories or tasks). As developers complete these tasks (ex: a task can be to build the back-end "read" API for a list of items that will be displayed on the UI), they perform unit tests and then commit their working code to repository. This committed code now is ready for another developer to integrate to. As developers commit, the whole user story slowly evolves and is stitched together. At all times working code is committed to the Git Hub repository. This is called continuous development and is the first milestone in our DevOps process


**Configuration Management:** We use GitHub as our source code repository. The master branch at origin of our source code control. Parallel to the master branch, we have three branches called:  

1. Master : stores the official release history. 

2. Staging : dedicated branch to prepare the release

3. Developer : initiated as a clone of master and used as the integration of code committed from every developer

4. Feature : used by the developers to build their features. Each new feature would reside in its own branch. Developers clone the code from the feature branch, make their changes on their workstations and then commit their changes to the feature branch after they run their 

Here is how developers code. To make it easier to explain, let's say a release is deployed now:

- The staging branch and master are the same right after the build
- for the new release, the work starts on the developer brach
- developer pulls the code to the feature branch to work on the feature that she'll be developing
- developer clones the feature branch to her computer and starts coding 
- developer completes code and unit tests for it
- developer validates the working code with automated and manual tests
- developer pushes the code back to feature branch from local
- developer merges the code to developer branch

## Continuous Integration and Automated Testing

![2](https://cloud.githubusercontent.com/assets/16209237/11881937/c4af8804-a4d7-11e5-8b68-4fac6a4cc905.png)

**Continuous Integration =** is the next key milestone to achieve in the DevOps workflow. Without continuous integration in place, real value from DevOps cannot be achieved. Continuous integration is bringing every developers code working on our prototype together and make sure that the over all build still works with everybody's code. Even though developer test their own code on their local computers and everything works, the over all code may not work when every developers code starts calling each other. This agile process ensures that the working code is healthy at all times. This health check cannot be achieved though without use of automated testing. It's not feasible and realistic to do this validation by manual testing.

**Automated Testing =** is the agile practice that makes DevOps real. Without automated testing, the whole iterative and continuous delivery concepts cannot be achieved. At the core, DevOps is maximizing automation. The ideal is to automate everything, but this is not possible. There is always manual check during the work flow. So the achievable nirvana is to automate as much as possible. This can be more an more as the teams automatically test as many things as possible. For this prototype, we were able to achieve automating:

- front end unit tests
- back end unit tests
- functional tests
- code quality scans
- security scan
- performance tests
- load test setup (execution is done ad-hoc, by developer discretion)

[see our automated testing documentation](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Automated-Testing.md)

## Continuous Deployment and Manual Testing

![3](https://cloud.githubusercontent.com/assets/16209237/11881939/c699427c-a4d7-11e5-84fc-62748442fcae.png)

**Continuous Deployment =** is a natural next step once all the automated tests run successfully after continuous integration using the code in developer integration branch. The gatekeeper of our git flow, in this case our technical architect, merges the changes in the Developer Branch to Staging Branch. As soon as the merge is complete, Jenkins CI server initiates the automated process for continuous deployment by running unit tests, static analysis, and code quality scan. Then Jenkins containerizes the application into a Docker file and deploys the release into the Staging Environments. The team is notified in Slack when the build is deployed as seen on the below image:

![jenkins integration into slack](https://cloud.githubusercontent.com/assets/16209237/11935745/83956a0c-a7d7-11e5-9169-50cadd37f68b.jpg)
**Manual Testing =** is performed on the Staging Environment. The following manual tests types are performed:

- Usability testing
- Story (functional) testing
- Exploratory testing

## Continuous Delivery

![4](https://cloud.githubusercontent.com/assets/16209237/11881941/c926bf24-a4d7-11e5-9714-eb87c1155b20.png)

We define continuous delivery as deliverying functionality that achieved our "definition of done" to production. This is the real value of DevOps. 

After the Staging code is verified by our automated checks and manual tests, a pull request is created to promote the release into the master branch. This pormotion wil automatically deploy the latest code into our production environment, where users can take advantage of the latest features and fixes. 

## Infrastructure

For a visualization of infrastructrue architecture please refer to [physical deployment model diagram](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Architecture-Diagrams.md#physical-deployment)

the flow is described in more detail in the following image :

![infrastructure_diagram](https://cloud.githubusercontent.com/assets/16209237/11957013/a955c074-a88c-11e5-9761-708455269cc7.png)


1) After a change is pushed to a git branch, our CI server builds an updated Docker image for that specific branch and application tier.

2) Containers are deployed and tested on the CI server. Containers are stopped after tests finish.
If tests pass...

3) The new image is pushed to Docker Registry.

4) Jenkins notifies the branch's corresponding EC2 machine [using Docker Machine] to pull new images. 

5) Containers are deployed on the live EC2 machine. A cAdvisor container is deployed to monitor resources.

## Monitoring

Monitoring was done with the help of tools like Prometheus, cAdvisor, and Slack.

Please see our [monitoring documentation](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Continuous-Monitoring.md) for more details

## Environments

All environments were provisioned using Amazon EC2 services.

The project uses four environments as show on the above figure :

**Developer Environment :**  is developer's local computer. Used to develop code and unit tests, perform tests and commit code to repository

**Developer Integration Environment :** is the test and integration environment for all of the developers. This is the environment where all developers validate the integration their code to others', by manual and automated testing.

**Staging Environment :** is used by the test team to validate the completed/ready (Definition of Done) capabilities. If both automated tests (functional, unit, performance, load and security tests) and manual tests (story, exploratory, section 508, usability) pass, the code (the current code is saved as a docker file to repository and waiting to be deployed) is now a release candidate. Based on product owners decision (acts as the gatekeeper in devops environment. Some times, test lead, tech lead, or architect might be the gatekeeper based on the change that is ready to be pushed to production.) the release could be automatically deployed to production using continuous delivery process.

## Tools used in our DevOps Environment

Jenkins : Manage continuous integration pipeline. Handle GIT hooks and automated Docker execution.

Docker Engine : Build and run containerized images for testing and deployment.

Docker Registry : A private image repository that new Docker images are pushed to prior to deployment.

Docker Machine: Provisions Docker-ready EC2 instances for each environment, and maintains a secure connection between.

Docker Compose: Orchestrate coupled container run time execution
