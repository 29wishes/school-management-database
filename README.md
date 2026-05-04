# school-management-database
A complete School Management System built with SQL Server.

## Project Description
This project demonstrates a fully functional School Management System with proper database design, normalization, relationships, and security features.

## Features
- Student and Parent Management
- Subject and Teacher Management  
- Many-to-Many relationships (Students ↔ Subjects, Students ↔ Parents)
- Role-based access control (Admin, Teacher, Parent)
- Data Masking on sensitive columns
- Automatic auditing and logging of changes

## File Structure
File -Description 
`schema/` - `CREATE TABLE` statements 
`data/`- Sample data insertion scripts 
`security/`- Roles, permissions, masking, auditing and triggers
`queries/` - Sample analytical queries 

## Technologies Used
- SQL Server (T-SQL)
- Role-Based Access Control
- Dynamic Data Masking
- Database Auditing
- Foreign Keys & Constraints

## Security Features Implemented
- Least Privilege Principle using custom Roles
- Dynamic Data Masking on contacts and dates of birth
- Audit logging for all changes on critical tables
- Proper Foreign Key constraints with `ON DELETE CASCADE`

## How to Setup
1. Create the database: `CREATE DATABASE SCHOOL;`
2. Run the scripts in this order:
   - Schema files
   - Data files
   - Security setup

## Future Enhancements
- Row-Level Security
- Power BI Dashboard
- Grade Management System
- Automated Backup Strategy

## Author
Neema Daniella
Aspiring Data Administrator / SQL Developer  
Nairobi, Kenya

