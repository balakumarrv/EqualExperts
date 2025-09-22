# GitHub Gist API (Java)

## Overview

This Spring Boot application provides a RESTful API to fetch public GitHub Gists for any given username. It interacts with the GitHub API and returns a simplified JSON response containing Gist ID, description, and URL.

## Features

- Fetch public Gists for any GitHub user
- RESTful endpoint: `GET /{username}`
- Multi-stage Dockerfile for optimized container image
- JUnit test for endpoint validation

## Prerequisites

- Java 17+
- Maven
- Docker (optional for containerization)

## Setup Instructions

1. **Build the project**:
   ```bash
   mvn clean package
   ```