-- Create Server Logins 
CREATE LOGIN SchoolAdminLogin WITH PASSWORD = 'AdminSecurePass123!';
CREATE LOGIN TeacherLogin WITH PASSWORD = 'TeacherSecure456!';
CREATE LOGIN ParentLogin WITH PASSWORD = 'ParentSecure789!';

-- Create Database Users
CREATE USER SchoolAdmin FOR LOGIN SchoolAdminLogin;
CREATE USER TeacherUser FOR LOGIN TeacherLogin;
CREATE USER ParentUser FOR LOGIN ParentLogin;

-- Create Custom Roles
CREATE ROLE School_Administrator;
CREATE ROLE Teacher_Role;
CREATE ROLE Parent_Role;
CREATE ROLE Reports_Viewer;        

-- Assign Users to Roles
ALTER ROLE School_Administrator ADD MEMBER SchoolAdmin;
ALTER ROLE Teacher_Role ADD MEMBER TeacherUser;
ALTER ROLE Parent_Role ADD MEMBER ParentUser;
ALTER ROLE Reports_Viewer ADD MEMBER ParentUser;  

-- Assign Permissions to Roles
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo 
    TO School_Administrator;
GRANT UNMASK TO SchoolAdmin;

GRANT SELECT ON student TO Teacher_Role;
GRANT SELECT ON subject TO Teacher_Role;
GRANT SELECT ON teacher TO Teacher_Role;
GRANT SELECT, INSERT, UPDATE ON subjectstudent TO Teacher_Role;
GRANT SELECT ON parentstudent TO Teacher_Role;

GRANT SELECT ON student TO Parent_Role;
GRANT SELECT ON parent TO Parent_Role;

GRANT SELECT ON SCHEMA::dbo TO Reports_Viewer;

PRINT ' User and Role Management Setup Completed!';

-- Create Audit Log Table
CREATE TABLE Audit_Log (
    AuditID       INT IDENTITY(1,1) PRIMARY KEY,
    TableName     VARCHAR(50) NOT NULL,
    ActionType    VARCHAR(10) NOT NULL,     -- INSERT, UPDATE, DELETE
    UserName      VARCHAR(128),
    ActionDate    DATETIME DEFAULT GETDATE(),
    OldValue      NVARCHAR(MAX),
    NewValue      NVARCHAR(MAX),
    AffectedID    INT,
    IPAddress     VARCHAR(50),
    Application   VARCHAR(100)
);

-- trigger for student

CREATE TRIGGER trg_Student_Audit
ON student
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @ActionType VARCHAR(10);

    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @ActionType = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @ActionType = 'INSERT';
    ELSE
        SET @ActionType = 'DELETE';
INSERT INTO Audit_LogSCH
 (TableName, ActionType, UserName, OldValue, NewValue, AffectedID)
    SELECT 
        'student',
        @ActionType,
        SUSER_NAME(),
        (SELECT * FROM deleted FOR XML RAW),      -- Old data
        (SELECT * FROM inserted FOR XML RAW),     -- New data
        COALESCE((SELECT student_id FROM inserted), (SELECT student_id FROM deleted))
        END;