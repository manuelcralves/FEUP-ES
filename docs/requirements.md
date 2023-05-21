
## Requirements


### Use case model 

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


### Domain model

 <p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2022-23/2LEIC10T1/blob/main/images/UML_page-0001.jpg"/>
</p>
