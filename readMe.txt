# Warehouse Simulation

This is a MySql Database simulation to represent a warehouses stock inventory for storing products being prepared to be shipped out to customers. 


## Instructions for Build and Use

Steps to build and/or run the software:

1. Run in powershell: pip install -r requirements.txt
2. Execute in powershell: docker start simulation-mysql
3. Execute the following to initilize the database
    Get-Content building_blocks.sql | docker exec -i simulation-mysql mysql -u root -pexample lola-blankets_db
    Get-Content locations_script.sql | docker exec -i simulation-mysql mysql -u root -pexample lola-blankets_db
    Get-Content products_script.sql | docker exec -i simulation-mysql mysql -u root -pexample lola-blankets_db

    This is to verify everything worked.
    Get-Content verifications.sql | docker exec -i simulation-mysql mysql -u root -pexample lola-blankets_db
4. Fill the database with 
    python fill_random_locations.py
5. Execute in powershell to enter docker: docker exec -it simulation-mysql mysql -u root -p
    password: example
6. call: USE lola-blankets_db;
7. Run Queries as desired

Instructions for using the software:

1. start your docker container doing this command 
    docker exec -it simulation-mysql mysql -u root -p
    password: example
2.  In here you can interact with the database in the Mysql Shell. Run queries or anything you desire.

## Development Environment 

To recreate the development environment, you need the following software and/or libraries with the specified versions:

* You will need Docker to recreate the MySql container to hold the database in real time. 
* Have Python 3.7+
* You will need to download the pip library, mysql-connector-python
    pip install mysql-connector-python
    or run 
    pip install -r requirements.txt

## Future Work

The following items I plan to fix, improve, and/or add to this project in the future:

* [ ] Create different python files to do specific real life simuations of buying and ordering stock.
* [ ] Create a way to add batch sheets for pickers to go grab the stock for the sorters
* [ ]