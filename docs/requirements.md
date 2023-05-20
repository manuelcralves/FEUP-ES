
## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

### Use case model 

Create a use-case diagram in UML with all high-level use cases possibly addressed by your module, to clarify the context and boundaries of your application.

Give each use case a concise, results-oriented name. Use cases should reflect the tasks the user needs to be able to accomplish using the system. Include an action verb and a noun. 

 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2022-23/2LEIC10T1/blob/main/images/UMLReq.png"/>
</p>

|||
| --- | --- |
| *Name* | Spotivibes |
| *Actor* |  User | 
| *Description* | The user has an entire music library with which he can interact, share playlists, check for lyrics, and get song information. |
| *Preconditions* | - The user need a phone. <br> - The user need internet connection. |
| *Postconditions* | - The user gets access to all the features of the app if is authenticated <br> - The user can search for songs, playlists and artists if is a guest. |
| *Normal flow* | 1. The user accesses the app Spotivibes.<br> 2. The user log in into his account.<br> 3. The system check if the login is correct.<br> 4. If it's correct then allow the user to entry his account. Else it sends a error message. <br> 5. Once loged in the user gets access to all the features. |
| *Alternative flows and exceptions* | 1. [Guest User] The user only has access to a limited features like search for songs, artists and playlists. |

### User stories
The user stories should be created as GitHub issues. Therefore, this section will *not* exist in your report, it is here only to explain how you should describe the requirements of the product as **user stories**. 

A user story is a description of desired functionality told from the perspective of the user or customer. A starting template for the description of a user story is 

*As a < user role >, I want < goal > so that < reason >.*

User stories should be created and described as [Issues](https://github.com/FEUP-LEIC-ES-2022-23/templates/issues) in GitHub with the label "user story". Check how to in the video [Creating a Product Backlog of User Stories for Agile Development using GitHub](https://www.youtube.com/watch?v=m8ZxTHSKSKE).

You should name the issue with the text of the user story, and, in the "comments" field, add any relevant notes, the image(s) of the user interface mockup(s) (check below) and the acceptance test scenarios (check below). 

**INVEST in good user stories**. 
You may add more details after, but the shorter and complete, the better. In order to decide if the user story is good, please follow the [INVEST guidelines](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/).

**User interface mockups**.
After the user story text, you should add a draft of the corresponding user interfaces, a simple mockup or draft, if applicable.

**Acceptance tests**.
For each user story you should write also the acceptance tests (textually in [Gherkin](https://cucumber.io/docs/gherkin/reference/)), i.e., a description of scenarios (situations) that will help to confirm that the system satisfies the requirements addressed by the user story.

**Value and effort**.
At the end, it is good to add a rough indication of the value of the user story to the customers (e.g. [MoSCoW](https://en.wikipedia.org/wiki/MoSCoW_method) method) and the team should add an estimation of the effort to implement it, for example, using t-shirt sizes (XS, S, M, L, XL).



### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module. 
Also provide a short textual description of each class. 

 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2022-23/2LEIC10T1/blob/main/images/UML_page-0001.jpg"/>
</p>
