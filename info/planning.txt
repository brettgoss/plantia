# TODO

## Index ##

Summary

Questions

  - What is it?
    - User Stories
    - Data

  - What does it do?
    - Features

  - How does it do it?
    - Stack

Wireframe




# Questions..
# v1.0 (MVP)

1. What is Plantia going to accomplish?
  - User Stories (as a user...)
    - I want to be able to keep track of what plants I have.
    - I want to be able to input information about each plant.
    - I want to be able to see a watering schedule for each plant.
    - I want to be able to see a plant dashboard with water status/countdown etc.

  - What data will it have?
    - Users
      - Name
      - Email
      - Password
      - Phone Number?

    - Plants
      - user_id
      - Plant-Name
      - Common Name
      - Light Info
      - Water Info
      - Misc Info

      - Sciency Name?
      - Wiki Picture?
      - User-uploaded Picture?

    - Logs
      - plant_id
      - title
      - log content
      - log date


  - How is that data stored?
    - See ERD
    - PostgreSQL

  - How is that data accessed?
    - Postgres database
    - Search external sources?
    - All plant data private to begin with.
    - Revisit sharing plant data with other users later.

  - How is that data presented?
    - Query relavant data per page


2. What is Plantia going to do?

  - Features
    - /feature/layout
      - landing page.
      - home/index.html

    - /feature/dashboard
      - plant dashboard with list of your plants and their watering info
      - home/dashboard

    - /feature/plant-info
      - specific plant information
      - home/plant:id

    - /feature/plant-watering
      - Contains water tracker based on information provided by the user
      - Displays on the individual plant page, and also the plant dashboard

    - /feature/plant-care
      - Contains care instructions based on information provided by the user

3. What are we building this with?

  # Server
    - Ruby/Rails

  # Frameworks
    - Rails
    ? Node.js
    ? React

  # Database
    - PostgreSQL

  # Design
    - SASS
    - Skeleton.css



# v2.0

1. What else is Plantia going to accomplish?

  - User Stories (as a user...)
    - I want to be able to have a vacation mode.





plant_name
-----------
user_id
common_name
light
water
misc



Mittens
------------
Brett
Venus Flytrap
Lots of indirect sunlight
Water every 2 - 3 days
PH neutral soil, do not fertilize.



