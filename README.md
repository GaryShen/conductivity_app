# Conductivity Web App
## Introduction
This Rails application allows users to upload or input N x N grids consisting of 0s and 1s to evaluate conductive paths from the top to the bottom of the grid.

## Setup
#### Install Dependencies:
```
bundle install
```
#### Database Migration:
```
rails db:migrate
```

#### Running the Server:
```
rails s
```
### Usage
#### Access the routes
`http://localhost:3000/grid_evaluations`
- Upload a grid file 
- Enter grid data manually.
- Use the "Generate Random Grid" button for random grids.

#### File Format for Upload
The file for uploading grid data should be in plain text format with each row of the grid separated by a newline. Each row should consist of 0s and 1s only.
Upload grid data in plain text format, like so:
```
1010
1110
0101
1101
```
Each line represents a grid row. '0's are non-conductive, '1's are conductive.
