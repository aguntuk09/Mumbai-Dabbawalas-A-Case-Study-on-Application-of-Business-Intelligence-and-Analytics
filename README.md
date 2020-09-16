# Mumbai-Dabbawalas-A-Case-Study-on-Application-of-Business-Intelligence-and-Analytics

# Masters in Data Analytics Project

## Project: Mumbai Dabbawalas - A Case Study on Application of Business Intelligence and Analytics

## Table of Contents

- [Overview of the organization](#overview)
- [Data Capture Points](#data)
- [Components](#components)
  - [Architecture creation](#arch)
  - [Mock data insertions](#mock)
  - [Creating visualizations](#visual)
- [Running the Code](#running)
- [Screenshots](#screenshots)
- [System Configuration steps](#config)
- [File Descriptions](#files)
- [Credits and Acknowledgements](#credits)

***

<a id='overview'></a>

### Overview of the organization

The Mumbai Tiffin Box Supplier's Association, commonly known as the Mumbai Dabbawalas, is a well-known organization which supplies lunch boxes to office and college going people. Founded in the year 1890 with a mere 100 dabbawalas, the organization has grown to a size of 5000 dabbawalas has continued to provide delivery services to almost 200,000 Mumbaikars. The end to end delivery process of dabba delivery has three teams. First team has around 20-25 dabbawalas who pick up dabba from the resident address. Second team segregates the dabbas as per the destination and the third team delivers the dabbas to the destination address. The same process is followed in a reverse fashion to deliver the empty dabba to the original pick-up address. The dabbas are coded using a special nomenclature, known by all the dabbawalas in the organization, which makes it easier for delivering the lunch boxes with precision. Realizing the need of the hour and current competition in the food delivery industry, the dabbawalas have adopted technology to maintain their position in the food delivery industry. This project involves the end to end creation of a BI and Analytics system for the Mumbai dabbawalas which includes a database, its various components (tables, data, triggers, etc.) and visulaizations using the data in Power BI.

<a id='data'></a>

### Data Capture Points

The diagram below provides details of the stages where new data are captured and updated to existing data are inserted into the database tables:

![Screenshot1](/images/Dabbawala_Data_Capture_Points.png)

<a id='components'></a>

### Components
There are three components to this project:

<a id='arch'></a>

#### Architecture creation
File _'Database_architecture_CR.sql'_ :

- Creates the `mumdab` database.
- Creates the schemas `employee`, `customer` and `salandser` along with the tables under them.
- Creates the triggers for the tables 

Below is the entity relationship diagram for the database:

![Screenshot2](/images/Mumbai_Dabbawala_ER_Diagram.png)

<a id='mock'></a>

#### Mock data insertions
Files ending with _'*_INS.sql' and '*_UPD.sql'_ :

- Inserts the data for the tables under `employee`, `customer` and `salandser` schemas
- Updates the data under `employee` and `customer` schemas for inactive personnel
- Executes the triggers automatically as per the insertions and updations in the tables

<a id='visual'></a>

#### Creating visualizations
Files ending with _'*.pbix'_ :

- Contains the visualizations created in Power BI

<a id='running'></a>

### Running the Code

In order to create the database and its underlying objects, run the following SQL scripts in the order given below:

- Database_architecture_CR.sql
- Employee_data_INS.sql
- Employee_grade_INS.sql
- Employee_type_INS.sql
- EmployeeFunctions_Data_INS.sql
- Employee_infractions_INS.sql
- Salandser_area_INS.sql
- Customer_Data_INS.sql
- customer_pickup_INS.sql
- customer_dropoff_INS.sql
- customer_infractions_INS.sql
- Inactive_Customers_UPD.sql

In order to view the visualizations, open the below files in Power BI Desktop:

- Active Customers.pbix
- Active Employees.pbix
- Customer Dashboard.pbix
- Customer Infraction.pbix
- Employee Dashboard.pbix
- Employee Infraction.pbix
- Inactive Customer.pbix
- Infraction.pbix

<a id='screenshots'></a>

### Screenshots

![Screenshot3](/images/active_customer_report.png)
![Screenshot4](/images/active_employee_report.png)
![Screenshot5](/images/customer_dashboard.png)
![Screenshot6](/images/customer_dropoff_area_report.png)
![Screenshot7](/images/customer_infraction_report.png)
![Screenshot8](/images/customer_pickup_area_report.png)
![Screenshot9](/images/employee_dashboard.png)
![Screenshot10](/images/employee_grade_report.png)
![Screenshot11](/images/employee_infraction_report.png)
![Screenshot12](/images/inactive_customer_infraction_report.png)
![Screenshot13](/images/inactive_customer_report.png)
![Screenshot14](/images/inactive_employees_report.png)
![Screenshot15](/images/inactive_employee_infraction_report.png)
![Screenshot16](/images/infractions_dashboard.png)

<a id='config'></a>

### System Configuration Steps

In order to run the code and see the visualizations, below are the necessary requirements:

- PowerBI: The visualizations have been created in PowerBI and hence requires PowerBI Desktop.
- Microsoft SQL Server: The data for the visualizations has been created as a database in SQL Server and requires the installation of SQL Server Express Edition along with SQL Server Management Studio as the IDE to run the scripts

<a id='files'></a>

### File Descriptions

Below are the files and the folders that are part of the project implementation:

1. SQL Server Codes:
- Database_architecture_CR.sql: Contains the SQL script for database architecture creation
- Employee_data_INS.sql: Contains the SQL scripts for employee details data insertion
- Employee_grade_INS.sql: Contains the SQL scripts for employee grade data insertion
- Employee_type_INS.sql: Contains the SQL scripts for employee type data insertion
- EmployeeFunctions_Data_INS.sql: Contains the SQL scripts for employee functions data insertion
- Employee_infractions_INS.sql: Contains the SQL scripts for employee infractions data insertion
- Salandser_area_INS.sql: Contains the SQL scripts for area code data insertion
- Customer_Data_INS.sql: Contains the SQL scripts for customer details data insertion
- customer_pickup_INS.sql: Contains the SQL scripts for customer pickup information data insertion
- customer_dropoff_INS.sql: Contains the SQL scripts for customer dropoff information data insertion
- customer_infractions_INS.sql: Contains the SQL scripts for customer infractions data insertion
- Inactive_Customers_UPD.sql: Contains the SQL scripts for update customer details to show inactive customers

2. Power BI packages:
- Active Customers.pbix: Contains the visualizations for active customers
- Active Employees.pbix: Contains the visualizations for active employees
- Customer Dashboard.pbix: Contains the visualizations for all customers
- Customer Infraction.pbix: Contains the visualizations for customer infractions
- Employee Dashboard.pbix: Contains the visualizations for all employees
- Employee Infraction.pbix: Contains the visualizations for employee infractions
- Inactive Customer.pbix: Contains the visualizations for inactive customers
- Infraction.pbix: Contains the visualizations for all personnel infractions

<a id='credits'></a>

### Credits and Acknowledgements

* [NCI](https://www.ncirl.ie/) for a challenging project as part of their full-time masters in data analytics course subject 'Business Intelligence and Business Analytics'
