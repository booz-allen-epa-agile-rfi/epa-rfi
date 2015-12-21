
## Our Application Stack and the Tools we used : 

![application_stack_v2_Crop](https://cloud.githubusercontent.com/assets/16209237/11935067/bbb9c2f6-a7d3-11e5-93d1-134779db3c09.png)

Our solution is comprised of more than five modern, open-source technologies.  Our selection of technologies was driven by several factors including the language, frameworks, and libraries most appropriate to solve the problem, the ability for the technology to conform to modern development best practices, and tools that best support the full end-to-end life cycle of development for maximum quality.  These factors were considered for the technologies selected for front-end, back-end, and dev-ops.

**a.) Front-End:** Bootstrap, Angular.JS, Node.js, Karma, LeafletJS

We decided on JavaScript for the front-end technology to ensure a highly decoupled front-end from back-end.

We selected LeafletJS for its ability to suypport our GeoJSON dataset, render vector layers, and provide map controls to create a smooth and interactive experience. 

AngularJS was selected to build-out the front-end as a single-page application.
Node.JS was used to host the front-end code and manages the resolution of front-end dependencies thorugh NPM.
We selectd Bootstrap as the framework to support the responsive web design.
Karma provides static code analysis and code quality metrics for JavaScript applications.

**b.) Backend:** Ruby, Rails, RSpec, Rubocop, Brakeman

Ruby/Rais was determined to be the most effective backend for the project given the ability to reuse code and complete the project in a short timeframe.  Rails provides many features such as scaffolding of controllers and views, built-in support for database migrations, and out-of-the-box input validation.  There are a large number of gems available that we were able to incorporate, such as Rubocop and Brakeman.

To support unit testing, code quality, and code security we selected RSpec, Rubocop, and Brakeman respectively.

**c.) Dev-Ops:** Docker (Machine, Registry, Compose), Jenkins, cAdvisor

Our motivations for the Dev Ops stack was to leverage open source technologies that would enable rapid creation and deployment of containers.  We also feel that an important aspect to achieving the maximum developer experience (DX) is to provide end-to-end solutions to include the components of the dev ops stack as part of the open source solution.   Therefore we selected Jenkins and Docker solutions that could run on-premise or in-cloud as opposed to SaaS based solutions.  This will help to ensure the greatest probablity of adoption in the solution within the open source community.

The team selected Jenkins over other options for the following reasons:
- Speed - On-premise jenkins server runs very fast.  Our build with Jenkins runs in less than a minute. 
- Flexibility – Jenkins is a complete open source solution for continuous integration and continuous deployment that can be run anywhere. Having full control over the testing, build, and deployment operations was important for us to remain open to different technologies we might leverage during the challenge. 
- Docker Integration - Jenkins allowed the construction of Docker images within the build server rather than having to leverage an external container build service. 

In the interest of meeting maximizing the value of our open source Dev-Ops stack, all of our build scripts were contributed to the repository:
https://github.com/booz-allen-epa-agile-rfi/epa-rfi/tree/master/bin/jenkins


# Physical Deployment Model:

![physical_deployment](https://cloud.githubusercontent.com/assets/16209237/11934954/06fd3b68-a7d3-11e5-8dbe-1b568917e655.png)

#Licenses

We used all open source technologies and open sourced our TREEVIEW prototype.

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/LICENSE

Licenses for open source technologies:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Licenses.md
