# Software Engineering Theory

## Software Paradigms

```
Software Paradigms
├─ Imperative
│   ├─ Procedural (e.g., C, Pascal)
│   └─ Object-Oriented (e.g., Java, C++, Python)
├─ Declarative
│   ├─ Functional (e.g., Haskell, Lisp, F#)
│   └─ Logic (e.g., Prolog)
└─ Other
    ├─ Event-Driven (e.g., JavaScript in browsers)
    └─ Aspect-Oriented (e.g., AspectJ)
```

- **Imperative:** Describes how to perform tasks (step-by-step instructions).
  - **Procedural:** Organizes code into procedures/functions.
  - **Object-Oriented:** Organizes code into objects/classes with data and behavior.
- **Declarative:** Describes what the result should be, not how to achieve it.
  - **Functional:** Uses pure functions and avoids changing state.
  - **Logic:** Uses rules and facts to derive conclusions.
- **Other:**
  - **Event-Driven:** System reacts to events or messages.
  - **Aspect-Oriented:** Separates cross-cutting concerns (like logging, security).

## System Modeling

System modeling is the process of creating abstract representations of a system to understand, design, and communicate its structure and behavior.

**Purpose:**

- Visualize and analyze system architecture, processes, and interactions
- Identify requirements, constraints, and potential issues early
- Facilitate communication among stakeholders

**Main Types of Models:**

- **Structural Models:** Show the organization of system components
  - Example: UML Class Diagram, Entity-Relationship Diagram
- **Behavioral Models:** Show how the system behaves over time
  - Example: UML Sequence Diagram, State Diagram, Activity Diagram
- **Functional Models:** Show what the system does (data flow, transformations)
  - Example: Data Flow Diagram (DFD), Use Case Diagram

**Example:**

- Use a class diagram to model the main entities in a library system (Book, Member, Loan)
- Use a sequence diagram to show the process of borrowing a book

### Common Diagrams

- **UML Class Diagram:**

  - Shows classes, their attributes, methods, and relationships (association, inheritance, etc.).
  - Used to model the static structure of a system.
  - Example: Visualizing entities like Book, Member, Loan in a library system.

- **UML Sequence Diagram:**

  - Illustrates how objects interact in a particular scenario, showing the order of messages over time.
  - Useful for modeling workflows, method calls, and system interactions.
  - Example: Steps involved when a user borrows a book.

- **UML State Diagram:**

  - Depicts the states an object can be in and how it transitions between states based on events.
  - Useful for modeling lifecycle of objects (e.g., Order: New → Paid → Shipped → Delivered).

- **UML Activity Diagram:**

  - Represents workflows, processes, or business logic as a flow of activities and decisions.
  - Good for visualizing parallel processes and complex logic.

- **Data Flow Diagram (DFD):**

  - Shows how data moves through a system, including sources, processes, data stores, and destinations.
  - Useful for understanding data processing and system boundaries.

- **Use Case Diagram:**
  - Illustrates system functionality from the user's perspective, showing actors and their interactions with use cases.
  - Helps identify system requirements and user goals.

## Class Diagram

### OOP Relationships Cheatsheet

```
Association
  ├─ Aggregation (specialized)
  └─ Composition (specialized)
```

- **Association**

  - Basic relationship: "knows a" / "uses a"
  - **Direct:** Class A is aware of Class B (A → B), but B is not aware of A
  - **Bidirectional (General):** Both classes are aware of each other (A ↔ B)
  - Aggregation and Composition are specialized associations (whole-part)
  - Examples: A Driver knows a Car; A Student attends a Course
  - UML: plain line

- **Aggregation**

  - "has-a" (whole-part, weak)
  - Container owns references to parts (not responsible for their lifecycle)
  - Examples: A Car has Wheels (Wheels can exist without the Car); A Library has Books (Books can exist elsewhere)
  - UML: line with hollow diamond

- **Composition**

  - "has-a" (whole-part, strong)
  - Container owns parts (responsible for their lifecycle)
  - Examples: A House has Rooms (Rooms do not exist without the House); A Human has a Heart (Heart ceases to exist if Human does)
  - UML: line with filled diamond

- **Generalization (Inheritance)**
  - "is-a"
  - Child class extends parent class
  - Example: A Car is a Vehicle
  - Enables code reuse and polymorphism
  - UML: line with hollow triangle

**Summary Table**

| Relationship | Example(s)                     | Can Part Exist Without Whole? | UML Notation   |
| ------------ | ------------------------------ | ----------------------------- | -------------- |
| Association  | Driver & Car, Student & Course | Yes                           | Plain line     |
| Aggregation  | Car & Wheel, Library & Book    | Yes                           | Hollow diamond |
| Composition  | House & Room, Human & Heart    | No                            | Filled diamond |

- **Dependency**
  - "depends on" (uses temporarily)
  - One class uses another (e.g., as a method parameter)
  - Examples: An OrderService uses a PaymentGateway; A Printer uses a Document
  - Relationship is temporary and unidirectional
  - UML: dashed arrow

## Use Cases and User Stories

### Use Cases

- Describe interactions between a user (actor) and the system to achieve a goal.
- Include main flow, alternative flows, preconditions, postconditions.
- Useful for capturing detailed functional requirements and system behavior.
- Often represented with UML diagrams.

**Example Use Case:**

- Title: Borrow Book
- Actor: Library Member
- Main Flow: Member searches for a book, selects it, and borrows it.
- Alternative Flow: Book is not available; member joins waitlist.
- Preconditions: Member is logged in.
- Postconditions: Book is marked as borrowed.

### User Stories

- Short, simple statements of a feature from the user's perspective.
- Focus on value delivered to the user; less formal than use cases.
- Format: "As a [user], I want [feature] so that [benefit]."
- Used in Agile methodologies for backlog and planning.

**Example User Stories:**

- As a <role> I want <goal> So that <benefit>
- As a member, I want to borrow a book so that I can read it at home.
- As a librarian, I want to see overdue books so that I can remind members.

#### Acceptance Criteria

- Define the conditions that must be met for a user story to be considered complete.
- Make user stories testable and unambiguous.
- Written as a checklist or bullet points.

**Example Acceptance Criteria:**

- User can borrow a book only if logged in
- System shows a confirmation message after borrowing
- Book status changes to "borrowed" in the catalog

### SPIDR

- **S**: Specific - Clearly define the feature.
- **P**: Purpose - Explain why it matters.
- **I**: Impact - Describe the effect on the user.
- **D**: Deliverables - List what will be delivered.
- **R**: Resources - Identify needed resources.

### Key Differences

- **Use Cases:** Detailed, structured, cover all flows, good for complex systems.
- **User Stories:** Concise, value-focused, easy to prioritize, good for Agile teams.

### When to Use

- Use cases: When you need detailed requirements, system interactions, or documentation.
- User stories: When you need quick, user-focused requirements for iterative development.

## SOLID Principles

- **Single Responsibility Principle:** Each class should do only one job. If it changes, it should be for one reason only.
- **Open/Closed Principle:** Classes should be easy to extend with new features, but you shouldn't have to change their existing code.
- **Liskov Substitution Principle:** You should be able to use child classes wherever you use a parent class, and everything should still work.
- **Interface Segregation Principle:** It's better to have several small, specific interfaces than one big, general one.
- **Dependency Inversion Principle:** Depend on abstract ideas (like interfaces), not on specific classes.

## Methodologies

Software development methodologies are systematic approaches to managing the software development process. They provide a framework for planning, executing, and controlling the life cycle processes.

### Agile

Agile is an iterative and incremental approach that prioritizes flexibility, collaboration, and customer feedback. It's a mindset based on the **Agile Manifesto**:

- **Individuals and interactions** over processes and tools
- **Working software** over comprehensive documentation
- **Customer collaboration** over contract negotiation
- **Responding to change** over following a plan

#### Scrum

Scrum is the most popular Agile framework. It organizes work into time-boxed **Sprints** (usually 2-4 weeks) to deliver a potentially shippable product increment.

- **Roles:** Product Owner (defines what), Scrum Master (facilitates how), Development Team (builds it).
- **Events:** Sprint Planning, Daily Scrum, Sprint Review, Sprint Retrospective.
- **Artifacts:** Product Backlog, Sprint Backlog, Increment.

#### Extreme Programming (XP)

XP is an Agile framework focused on technical excellence and continuous feedback. Key practices include:

- **Test-Driven Development (TDD):** Write tests before writing code.
- **Pair Programming:** Two developers work together at one computer.
- **Continuous Integration (CI):** Integrate and build code frequently.
- **Simple Design:** Keep the design as simple as possible (YAGNI, DRY).

### Waterfall

Waterfall is a linear, sequential methodology where each phase must be completed before the next begins.

- **Phases:** Requirements → Design → Implementation → Verification → Maintenance.
- **Best For:** Projects with stable, well-defined requirements where change is unlikely (e.g., some safety-critical or regulated systems).

### Comparison

| Methodology | Approach            | Flexibility | Key Feature        | Best For                      |
| ----------- | ------------------- | ----------- | ------------------ | ----------------------------- |
| Agile       | Iterative           | High        | Customer feedback  | Evolving requirements         |
| Scrum       | Iterative (Sprints) | High        | Sprints, Roles     | Complex, adaptive projects    |
| XP          | Iterative           | High        | Technical practices| Rapid change, high quality    |
| Waterfall   | Sequential          | Low         | Strict phases      | Stable, well-defined projects |

### DevOps

DevOps is a culture, philosophy, and set of practices that integrates software development (Dev) and IT operations (Ops). The goal is to shorten the development life cycle and provide continuous delivery with high software quality.

#### The Three Ways of DevOps

1.  **The First Way (Systems Thinking):** Focus on the performance of the entire system, not just a specific part. This means understanding the flow of work from development to operations and continuously improving it.
2.  **The Second Way (Amplify Feedback Loops):** Create fast and constant feedback loops from right to left. This helps identify and fix problems closer to their source, preventing them from recurring.
3.  **The Third Way (Culture of Continual Experimentation and Learning):** Foster a culture that encourages taking risks, learning from failure, and understanding that repetition and practice are prerequisites to mastery.

#### Core Concepts (CALMS Framework)

-   **C**ulture: Foster a collaborative, blame-free environment.
-   **A**utomation: Automate everything possible in the build, test, and deployment pipeline.
-   **L**ean: Apply lean principles to eliminate waste and optimize the value stream.
-   **M**easurement: Measure everything to drive improvement and prove success.
-   **S**haring: Share ideas, knowledge, and tools across teams.

#### Key Practices and the DevOps Toolchain

| Stage                      | Goal                                      | Key Practices                                       | Example Tools                                    |
| -------------------------- | ----------------------------------------- | --------------------------------------------------- | ------------------------------------------------ |
| **Plan**                   | Define features and track work            | Agile planning, issue tracking                      | Jira, Trello, Azure Boards                       |
| **Code**                   | Develop and review code                   | Version control, code reviews, pair programming     | Git (GitHub, GitLab), VS Code                    |
| **Build**                  | Compile code and create artifacts         | Continuous Integration (CI), build automation       | Jenkins, GitLab CI, GitHub Actions, Azure Pipelines |
| **Test**                   | Ensure quality through automated testing  | Continuous Testing, TDD, BDD                      | Selenium, JUnit, Pytest, Cypress                 |
| **Release**                | Automate application deployment           | Continuous Delivery/Deployment (CD), release gates  | Jenkins, GitLab CI, Argo CD, Spinnaker           |
| **Deploy & Operate**       | Manage infrastructure and run applications| Infrastructure as Code (IaC), containerization      | Docker, Kubernetes, Terraform, Ansible, Puppet   |
| **Monitor**                | Observe application and system performance| Log management, performance monitoring, alerting    | Prometheus, Grafana, ELK Stack, Datadog, Splunk  |

#### CI/CD: The Backbone of DevOps

-   **Continuous Integration (CI):** Developers frequently merge their code changes into a central repository, after which automated builds and tests are run. The goal is to find and address bugs quicker, improve software quality, and reduce the time it takes to validate and release new software updates.
-   **Continuous Delivery (CD):** An extension of CI where code changes are automatically built, tested, and prepared for a release to production. It expands upon CI by deploying all code changes to a testing environment and/or a production environment after the build stage.
-   **Continuous Deployment (CD):** The final step, where every change that passes all stages of the production pipeline is released to customers. There's no human intervention, and only a failed test will prevent a new change from being deployed to production.

#### Infrastructure as Code (IaC)

IaC is the practice of managing and provisioning infrastructure through code and software development techniques, such as version control and continuous integration. It enables you to build, change, and manage your infrastructure in a safe, consistent, and repeatable way by defining resource configurations that you can version, reuse, and share.

-   **Declarative (Functional):** Focuses on the desired end state ("what"). You define what you want, and the IaC tool figures out how to achieve it. (e.g., Terraform, Kubernetes YAML).
-   **Imperative (Procedural):** Focuses on the specific commands needed to achieve the desired configuration ("how"). You write scripts that execute in a specific order to create the infrastructure. (e.g., Ansible, Chef, Puppet).

## Software Life Cycle Processes

The software life cycle encompasses all stages from conception to retirement. **ISO/IEC/IEEE 12207** provides a standard framework for these processes, ensuring all necessary activities are considered. It defines *what* needs to be done, while methodologies (like Agile or Waterfall) define *how* it gets done.

### Key Process Groups (Simplified from ISO 12207)

- **Agreement Processes:** Activities for establishing an agreement between a supplier and an acquirer (e.g., contracts).
- **Organizational Project-Enabling Processes:** Activities that support the project at an organizational level (e.g., management, infrastructure, quality assurance).
- **Technical Processes:** The core engineering activities for creating the software product.
- **Support Processes:** Activities that support the technical processes (e.g., documentation, configuration management, problem resolution).

### Focus on Technical Processes

The technical processes are central to development and are where most engineers operate.

1.  **Requirements Analysis:** Elicit, analyze, and define stakeholder needs. This produces functional (what it does) and non-functional (how it does it) requirements.
2.  **Architectural Design:** Define the high-level structure, components, interfaces, and data for the system to satisfy specified requirements.
3.  **Implementation:** Create the actual software components (code).
4.  **Integration:** Combine software components into a complete system.
5.  **Testing (Verification & Validation):**
    - **Verification:** "Are we building the product right?" (Does it meet the design specifications?).
    - **Validation:** "Are we building the right product?" (Does it meet the user's needs?).
6.  **Installation & Deployment:** Put the software into operation.
7.  **Maintenance:** Modify the software after delivery to correct faults, improve performance, or adapt to a changed environment.

## Software Quality

Software quality defines how well a system meets the needs of its users and stakeholders. It's not just about being bug-free.

### Quality Model: ISO/IEC 25010

**ISO/IEC 25010** is the international standard for software product quality. It defines a model with eight key characteristics.

| Characteristic         | Description & Examples                                                                                          |
| ---------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Functional Suitability** | Does it do the right things? (Completeness, correctness)                                                        |
| **Performance Efficiency** | How fast and resource-efficient is it? (Response time, CPU/memory usage)                                        |
| **Compatibility**      | Can it work with other systems? (Co-existence, interoperability)                                                |
| **Usability**          | Is it easy and pleasant to use? (Learnability, accessibility)                                                   |
| **Reliability**        | Is it stable and dependable? (Uptime, fault tolerance, recoverability)                                          |
| **Security**           | Can it protect information from unauthorized access? (Confidentiality, integrity)                               |
| **Maintainability**    | Is it easy to modify and test? (Modularity, reusability, testability)                                           |
| **Portability**        | Can it run in different environments? (Adaptability, installability)                                            |

### Security Deep Dive: ISO/IEC 27002

While **ISO 25010** defines *security* as a quality characteristic, **ISO/IEC 27002** provides a practical code of practice for *how* to implement information security controls. It's a detailed catalog of best practices to achieve confidentiality, integrity, and availability (the "CIA Triad").

**Key Control Areas (Examples from ISO 27002):**

- **Access Control:** Policies and procedures to control who can access information.
- **Cryptography:** Using encryption to protect data at rest and in transit.
- **Physical and Environmental Security:** Protecting hardware and facilities.
- **Communications Security:** Securing networks and data transfer.
- **Secure Development:** Building security into the software development life cycle (DevSecOps).
- **Incident Management:** Planning for and responding to security breaches.

## Design Patterns

Design patterns are reusable, well-documented solutions to commonly occurring problems within a given context in software design. They are not finished designs that can be transformed directly into code, but rather templates for how to solve a problem.

### Creational Patterns

These patterns provide object creation mechanisms that increase flexibility and reuse of existing code.

| Pattern           | Description                                                                                             | When to Use                                                                                             |
| ----------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Factory Method**| Defines an interface for creating an object, but lets subclasses alter the type of objects that will be created. | When you don't know beforehand the exact types and dependencies of the objects your code should work with. |
| **Abstract Factory**| Lets you produce families of related objects without specifying their concrete classes.                  | When your system needs to be independent of how its products are created, composed, and represented.      |
| **Builder**       | Lets you construct complex objects step by step. The pattern allows you to produce different types and representations of an object using the same construction code. | When you want to create a complex object that requires laborious step-by-step initialization of many fields and nested objects. |
| **Singleton**     | Ensures a class has only one instance, while providing a global access point to this instance.            | When a class in your program should have just a single instance available to all clients; for example, a single database object shared by different parts of the program. |
| **Prototype**     | Lets you copy existing objects without making your code dependent on their classes.                       | When your code shouldn't depend on the concrete classes of objects that you need to copy.                |

### Structural Patterns

These patterns explain how to assemble objects and classes into larger structures, while keeping these structures flexible and efficient.

| Pattern           | Description                                                                                             | When to Use                                                                                             |
| ----------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Adapter**       | Allows objects with incompatible interfaces to collaborate.                                             | When you want to use some existing class, but its interface isn't compatible with the rest of your code. |
| **Bridge**        | Lets you split a large class or a set of closely related classes into two separate hierarchies—abstraction and implementation—which can be developed independently of each other. | When you want to divide and organize a monolithic class that has several variants of some functionality. |
| **Composite**     | Lets you compose objects into tree structures and then work with these structures as if they were individual objects. | When you have to implement a tree-like object structure.                                                 |
| **Decorator**     | Lets you attach new behaviors to objects by placing these objects inside special wrapper objects that contain the behaviors. | When you want to be able to assign extra behaviors to objects at runtime without breaking the code that uses these objects. |
| **Facade**        | Provides a simplified interface to a library, a framework, or any other complex set of classes.           | When you need to have a limited but straightforward interface to a complex subsystem.                     |
| **Flyweight**     | Lets you fit more objects into the available amount of RAM by sharing common parts of state between multiple objects instead of keeping all of the data in each object. | When your program must support a huge number of objects which barely fit into available RAM.            |
| **Proxy**         | Lets you provide a substitute or placeholder for another object. A proxy controls access to the original object, allowing you to perform something either before or after the request gets through to the original object. | When you want to provide a more sophisticated or controlled access to a particular object.              |

### Behavioral Patterns

These patterns are concerned with algorithms and the assignment of responsibilities between objects.

| Pattern           | Description                                                                                             | When to Use                                                                                             |
| ----------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Chain of Responsibility** | Lets you pass requests along a chain of handlers. Upon receiving a request, each handler decides either to process the request or to pass it to the next handler in the chain. | When your program is expected to process different kinds of requests in various ways, but the exact types of requests and their sequences are unknown beforehand. |
| **Command**       | Turns a request into a stand-alone object that contains all information about the request. This transformation lets you pass requests as a method arguments, delay or queue a request's execution, and support undoable operations. | When you want to parameterize objects with operations.                                                   |
| **Iterator**      | Lets you traverse elements of a collection without exposing its underlying representation (list, stack, tree, etc.). | When your collection has a complex data structure under the hood, but you want to hide its complexity from clients. |
| **Mediator**      | Lets you reduce chaotic dependencies between objects. The pattern restricts direct communications between the objects and forces them to collaborate only via a mediator object. | When it's hard to change some of the classes because they are tightly coupled to a bunch of other classes. |
| **Memento**       | Lets you save and restore the previous state of an object without revealing the details of its implementation. | When you want to produce snapshots of the object's state to be able to restore a previous state of the object. |
| **Observer**      | Lets you define a subscription mechanism to notify multiple objects about any events that happen to the object they’re observing. | When changes to the state of one object may require changing other objects, and the actual set of objects is unknown beforehand or changes dynamically. |
| **State**         | Lets an object alter its behavior when its internal state changes. It appears as if the object changed its class. | When you have an object that behaves differently depending on its current state, the number of states is enormous, and the state-specific code changes frequently. |
| **Strategy**      | Lets you define a family of algorithms, put each of them into a separate class, and make their objects interchangeable. | When you want to use different variants of an algorithm within an object and be able to switch from one algorithm to another during runtime. |
| **Template Method**| Defines the skeleton of an algorithm in the superclass but lets subclasses override specific steps of the algorithm without changing its structure. | When you want to let clients extend only particular steps of an algorithm, but not the whole algorithm or its structure. |
| **Visitor**       | Lets you separate algorithms from the objects on which they operate.                                    | When you need to perform an operation on all elements of a complex object structure (for example, an object tree). |

## System Architecture

System architecture defines the high-level structure of a software system, the discipline of creating such a structure, and the documentation of this structure. It is the set of decisions regarding the organization of a software system, the selection of the structural elements and their interfaces by which the system is composed, and their behavior as specified in the collaborations among those elements.

### Monolithic vs. Microservices

| Aspect              | Monolithic Architecture                                       | Microservices Architecture                                  |
| ------------------- | ------------------------------------------------------------- | ----------------------------------------------------------- |
| **Definition**      | The entire application is built as a single, unified unit.    | The application is broken down into a collection of smaller, independent services. |
| **Development**     | Simpler to develop initially.                                 | More complex to set up initially.                           |
| **Deployment**      | Deployed as a single artifact. A small change requires redeploying the entire application. | Services can be deployed independently.                     |
| **Scalability**     | Can only be scaled as a whole unit.                           | Services can be scaled independently based on demand.       |
| **Technology Stack**| A single, homogeneous technology stack.                       | Each service can use its own technology stack.              |
| **Fault Isolation** | A failure in one part of the application can bring down the entire system. | A failure in one service is isolated and won't affect others. |
| **Data Management** | A single, centralized database.                               | Each service has its own database.                          |
| **Best For**        | Small applications, startups, and simple projects.            | Large, complex applications and large development teams.    |

### Other Architectural Patterns

-   **Layered (n-tier) Architecture:** Separates the application into layers (e.g., presentation, business, persistence, database). Each layer has a specific responsibility and communicates only with the layer below it.
-   **Event-Driven Architecture:** Components communicate through events. This is a decoupled architecture that is highly scalable and resilient.
-   **Service-Oriented Architecture (SOA):** A predecessor to microservices, where services are often larger and communicate through an enterprise service bus (ESB).
-   **Client-Server Architecture:** A classic model where a client requests resources and a server provides them.

## Cloud & Deployment Basics

### CI/CD (Recap)

-   **Continuous Integration (CI):** Automates the building and testing of code every time a team member commits changes to version control.
-   **Continuous Delivery (CD):** Automates the release of that validated code to a repository.
-   **Continuous Deployment (CD):** Automatically deploys every change that passes the CI/CD pipeline to production.

### Containers

Containers are a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

-   **Docker:** The most popular containerization platform. It allows you to build, ship, and run applications in containers.
-   **Container Image:** A lightweight, standalone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.
-   **Container:** A runtime instance of an image.

### Orchestration

Container orchestration automates the deployment, management, scaling, and networking of containers.

-   **Kubernetes (K8s):** The leading container orchestration platform. It helps you manage containerized applications in a clustered environment.
-   **Key Kubernetes Concepts:**
    -   **Pod:** The smallest deployable unit in Kubernetes, which can contain one or more containers.
    -   **Service:** An abstraction that defines a logical set of Pods and a policy by which to access them.
    -   **Deployment:** A resource object in Kubernetes that provides declarative updates to applications.
    -   **Ingress:** An API object that manages external access to the services in a cluster, typically HTTP.
    -   **ConfigMap/Secret:** Used to store configuration data and secrets, respectively.

## Security Best Practices

### OWASP Top 10

The OWASP Top 10 is a standard awareness document for developers and web application security. It represents a broad consensus about the most critical security risks to web applications.

1.  **A01:2021-Broken Access Control:** Restrictions on what authenticated users are allowed to do are not properly enforced.
2.  **A02:2021-Cryptographic Failures:** Failures related to cryptography (or lack thereof), which can lead to exposure of sensitive data.
3.  **A03:2021-Injection:** Flaws that allow untrusted data to be sent to an interpreter as part of a command or query.
4.  **A04:2021-Insecure Design:** A new category focusing on risks related to design flaws.
5.  **A05:2021-Security Misconfiguration:** Insecure default configurations, incomplete or ad-hoc configurations, open cloud storage, misconfigured HTTP headers, and verbose error messages containing sensitive information.
6.  **A06:2021-Vulnerable and Outdated Components:** Using components with known vulnerabilities.
7.  **A07:2021-Identification and Authentication Failures:** Incorrectly implemented functions related to user identity and session management.
8.  **A08:2021-Software and Data Integrity Failures:** A new category focusing on making assumptions related to software updates, critical data, and CI/CD pipelines without verifying integrity.
9.  **A09:2021-Security Logging and Monitoring Failures:** Insufficient logging and monitoring, coupled with missing or ineffective integration with incident response.
10. **A10:2021-Server-Side Request Forgery (SSRF):** A new category, where a web application is fetching a remote resource without validating the user-supplied URL.