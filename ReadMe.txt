This repo is for server side mangement of the Weather station project under CS404 course of IIT Mandi, Mentored by Prof. Mark A. Yoder.

Team Members

1. Sanjeev Khare
2. Tushar Jain
3. Charlotte
4. Merlin

This the link to our google drive folder which contains documentation of development and current status of the project.

https://drive.google.com/folderview?id=0B72mj0XcA804eFJ0dUNGZHI3S0E&usp=sharing

Feedback document in the folder has comments enabled. Please use it to give feedback.


Crashes can be handled in the following way:
1. Using crontab to poll a script which checks if phant is running or not & starts phant if not running.
2. Using Forever module to start phant, i.e. forever phant
3. Using the concept of parent & child process. 
	E.g:
until '/usr/local/bin/phant 2>&1 | logger'; do
    echo "Server 'phant' crashed with exit code $?.  Respawning.." >&2
    sleep 1
done


PS: Always use complete path to all binaries/executabes when referring them in crontab.
