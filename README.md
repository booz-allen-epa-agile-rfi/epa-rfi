# EPA Office of Environmental Information (OEI) – Booz Allen Digital– Prototype: TREEVIEW

Prototype URL: https://treeview.io 

Please evaluate our development branch :

https://github.com/booz-allen-epa-agile-rfi/epa-rfi

## Prototype Overview - HOMAN EDIT

[![Build Status](http://jenkins.treeview.io/buildStatus/icon?job=Development_FrontEnd_Builder)](http://jenkins.treeview.io/view/Development/job/Development_FrontEnd_Builder/)[![Build Status](http://jenkins.treeview.io/buildStatus/icon?job=Development_API_Builder)](http://jenkins.treeview.io/view/Development/job/Development_API_Builder/)Development Branch Server: http://dev.treeview.io

[![Build Status](http://jenkins.treeview.io/buildStatus/icon?job=Master_FrontEnd_Builder)](http://jenkins.treeview.io/view/Master/job/Master_FrontEnd_Builder/)[![Build Status](http://jenkins.treeview.io/buildStatus/icon?job=Master_API_Builder)](http://jenkins.treeview.io/view/Master/job/Master_API_Builder/)Master Branch Server: http://treeview.io

TREEVIEW is a data-driven platform with the goal of helping the user discover where chemical emissions are coming from in their local community using the latest information from the EPA’s Toxics Release Inventory and Superfund Program.   Through TREEVIEW, a concerned citizen is able to filter through EPA information by chemical type, related health effects, and facilities to provide the data in a way that meets an individual need.   

Booz Allen Digital offers key strengths to the EPA OEI:

- **Demonstrated Agile Delivery** – Our firm has strong experience with agile software development as demonstrated on this prototype as well as on GSA Integrated Award Environment (IAE), GSA 18F, numerous hackathons, and many other federal and commercial engagements.  For this engagement, we were able to pull together an agile team across three time zones and demonstrate distributed DevOps.

- **A Culture of Innovation** - Booz Allen's dedication to creating a culture of innovation resulted in the Strategic Innovation Group (SIG), a 1,800 team whose mission it is to ensure there is focus on agile, digital, next gen analytics and cyber security for all modern solutions.

- **Cross-functional agile skilled staff with reach back to domain SME** – Booz Allen was able to quickly assemble a highly-skilled, cross-functional team for this effort. Booz Allen has deep knowledge of federal agencies missions and a staff deeply familiar with the EPA.

### Digital Services Playbook

We closely followed the Digital Services playbook guidelines as detailed in the link below: 

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/U.S.-Digital-Services-Playbook-Evidence.md

### Technical Approach 

**(a) User-Centered Design**

We assigned one leader, our Product Owner (PO), who had the authority, responsibility, and was held accountable for the quality of our TREEVIEW prototype submission.  The PO was responsible for defining the initial prototype concept and attended all sprint planning and demonstrations, making the decisions about scope, priority, and usability.  From the beginning of our prototype development, we included ‘people’ throughout the process to understand their needs and get their feedback on our design and development. 

During this challenge, we used 8 core Human Centered Design (HCD) techniques: (1) Visioning exercise to brainstorm target groups, features/services to meet their needs; (2) Personas; (3) Journey Mapping; (4) User Stories; (5) Sketching screen designs; (6) Paper Prototyping with Wireframes; (7) Heuristic Reviews based on researched best practices and industry standards for designing for real, live people; (8) Usability testing in 2 small-scale iterative rounds of moderated in-person and remote testing. Here is an overview of our lean HCD process:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Human-Centered-Design.md

Our user stories:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/User-Stories.md

Our personas: 

(need link)

**(b) DevOps Approach NEEDS LINK**

We decided that we wanted to build a prototype that not only intuitively displayed data from 2 of the EPA datasets but also included a front end API to allow for a third party to pull data into their application.   Given this scope, we assembled a multidisciplinary and collaborative distributed team consisting of a Product Owner, Agile Coach, Technical Architect, User Interface / User Experience Designer, Content Manager, DevOps Engineer, Front End Developers and Back End Developers. 

Our humans.txt file:  NEED LINK

Our DevOps workflow:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/DevOps-Process.md


**(c) Agile Software Development NEEDS COPY**

We developed TREEVIEW using an iterative approach where feedback informed subsequent versions of the prototype through 6 sprints. In the first Sprint, we tailored Booz Allen Digital’s existing agile development tools and environment which includes a continuous delivery infrastructure.  We conducted sprint planning at the beginning of each sprint and conducted a prototype demonstration and retrospective at the end of each sprint. The EPA SMEs and PO attended the planning sessions, the reviews, and provided feedback that informed subsequent work.

Our iterative agile process:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Agile-Artifacts.md

Our Team structure:


**(e) Agile Architecture NEEDS EDIT and COPY**

We used all open source technologies and open sourced our TREEVIEW prototype.

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Architecture-Diagrams.md

Licenses for open source technologies:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Licenses.md

**(f) Modular Development**

We developed TREEVIEW with 14 modern, open source technologies most appropriate to implement the prototype.  The team utilized GitHub for distributed source control.  We leveraged the GitFlow model of propagating code from feature branches, to development, to release, and finally to production. The Docker tool suite allowed seamless containerization and configuration management of the front-end, back-end (API) and database applications.  We used Docker-engine to build Linux containers from custom Dockerfiles stored in our Git repository. We containerized all 3 tiers of our application stack. We wrote Dockerfiles using Docker’s recommended best practices to maximize the caching features of the Docker tool. This allows for quicker builds, which is important as the Docker image is rebuilt after every push.

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/DevOps-Process.md

- Front-End: Bootstrap, Angular.JS, Node.js, Karma, JS Hint, nvd3, Leaflet
- Backend: Ruby, Rails, RSpec, Rubocop, Brakeman 
- Dev-Ops: Docker (Machine, Registry, Compose), Jenkins, cAdvisor

Our application stack:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Architecture-Diagrams.md

**(g) Test Driven Development**

The concept behind Test Driven Development (TDD) is that the test cases for the code to be developed should be created before the code is implemented. This way the test cases being developed for the code are based solely on the requirements and are not influenced by the implementation of the requirements in the code.  Keeping with this pattern, we implemented a number of our tests for the front-end and back-end APIs based on our user stories, use cases, and personas.  Once the tests were completed, we wrote our code to the tests. 

We wrote unit tests for code, written with appropriate tooling for the technology stack. We used Karma for front-end code and used rSpec for the backend API. Our unit testing enabled a fluid development process while leveraging the respective language specific advantages of each testing technology. The unit tests were executed both locally and on the continuous integration server (Git push).

We use Jenkins as our continuous integration system to automate the running of tests and continuously deploy our code. We established GitHub hooks for each branch to kickoff Jenkins jobs. Custom jobs for each branch ran automated tests in containerized environments. Once tests were completed, Jenkins CI updated the Docker registry and deployed the new build. All pushes to the development branch are automatically examined by static code analysis, security scans, unit tests, integration tests, and performance tests. Load testing was performed ad-hoc (developer’s discretion).

Our automated testing approach:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Automated-Testing.md


**(h) API First Design**

The concept behind API First is that you design and develop your APIs first before developing your delivery channels such as mobile application or web.  The APIs are designed based on user stories and the available data sets, and iedally not influenced by any particular channel.

For TREEVIEW we first reviewed and discussed our user stories and the chemical release data set to determine the required methods and functionality for our APIs.  Once we designed the API, we were then able to build out the tests and code for our front-end and back-end API.



