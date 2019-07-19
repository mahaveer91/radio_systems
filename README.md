# RadioSystem

### Requirements:

- docker
- docker-compose

### To Run the application:

First time, run the command `docker-compose build`

After running that, use the command to Start the web Application: `docker-compose up`

### Application Overview:

Create a simple service for handling of devices in a Motorola radio system.

A device profile should be a record containing the following information:
- Radio ID (a unique integer)
- Radio alias (a string name)
- List of allowed locations (each location being a simple string id)

Additionally each device has a location (a string), that initially is set to undefined.

 The service should fulfill the following requirements:

Implement a REST API that allows the following:

#### Storage of radio profiles:
```
        POST /radios/{id}

            Payload should be JSON following this schema:
            {
            “alias”: string,
            “allowed_locations”: array<string>
            }
```
#### Setting a location of a radio that is accepted if the location is on the radio’s list of allowed locations and rejected otherwise. If location change is rejected radio’s location remains the last accepted location
```        
        POST /radios/{id}/location

            Payload should be JSON following this schema:
            {
            “location”: string
            }

            Returns 200 OK for valid location

            Returns 403 FORBIDDEN for invalid location
```
#### Retrieval of a radio’s location
```
        GET /radios/{id}/location

            Returns 200 OK with location in JSON form following the schema
            {
            “location”: string
            }

            Returns 404 NOT FOUND if no location exists
```
- How the service stores data is up to you.
- You can also use any programming language you want
- Bonus points if you include a Dockerfile with all the dependencies that allows us to run your code inside a Docker container
- Your code should be uploaded to your GitHub account

### Example use cases:

## Scenario 1:

    Create a radio profile with ID: 100, Alias: “Radio100”, Allowed Locations: [“CPH-1”, “CPH-2”]
    POST /radios/100
    Payload: { "alias": "Radio100", "allowed_locations": ["CPH-1", "CPH-2"] }

    Create a radio profile with ID: 101, Alias: “Radio101”, Allowed Locations: [“CPH-1”, “CPH-2”, “CPH-3”]
    POST /radios/100
    Payload: { "alias": "Radio101", "allowed_locations": ["CPH-1", "CPH-2", “CPH-3”] }

    Set location of radio 100 to “CPH-1”
    POST /radios/100/location
    Payload: { "location": "CPH-1" }
    Return: 200 OK

    Set location of radio 101 to “CPH-3” (accepted)
    POST /radios/101/location
    Payload: { "location": "CPH-3" }
    Return: 200 OK

    Set location of radio 100 to “CPH-3” (denied)
    POST /radios/100/location
    Payload: { "location": "CPH-3" }
    Return: 403 FORBIDDEN

    Retrieve location of radio 101 (returns “CPH-3”)
    GET /radios/101/location
    Return: 200 OK { “location”: “CPH-3” }

    Retrieve location of radio 100 (returns “CPH-1”)
    GET /radios/100/location
    Return: 200 OK { “location”: “CPH-1” }


## Scenario 2:

    Create a radio profile with ID: 102, Alias: “Radio102”, Allowed Locations: [“CPH-1”, “CPH-3”]
    POST /radios/102
    Payload: { "alias": "Radio102", "allowed_locations": ["CPH-1", "CPH-3"] }

    Retrieve location of radio 102 (returns undefined/unknown)
    GET /radios/102/location
    Return: 404 NOT FOUND
