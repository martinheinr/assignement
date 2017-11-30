# Assignement

# Thank you for the opportunity
You can find client app in the folder app

Since I was doing deployment to Heroku with git, api is in another repo: [api](https://github.com/martinheinr/ruby)

Unfortunatley, you will notice that the client application is not finished. Client would not be able to UPDATE data on recently created companies.


### Question 1: Propose a protocol / method for webservice authentication and justify your choice.

I would use token method, since it is possible to have encrypted tokens, it would be hard to steal one and decrypt it 


### Question 2: How can you make the service redundant? What considerations should you do?

I would set up additional server that would be configured to start to run in case of service faliure.
Downtime have to be minimized as much as possible
Service must be secured in any case
It is very important to have backups scheduled and updated all the time


### Question 3: How can you implement versioning of all the data?
It is recommended to think about the versioning befor the development. As it is possible to see at the api I have created the namespace is set on /ap1/v1/ so it is known that all the configuration mathers to v1 that can be reffered as a version one. On this way each version has complete sset of services and there is no mixing. It is always clear about the version we are talking abpout. in this case version 1  /api/{version number}/...

