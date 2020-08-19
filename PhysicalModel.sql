


CREATE TABLE Hospitals(
	Hospital_ID varchar2(10) NOT NULL,
	Hospital_Name varchar2(150) NOT NULL,
	Hospital_Address varchar2(250) NOT NULL,
	Phone varchar2(25) NOT NULL,
 CONSTRAINT PK_Hospitals PRIMARY KEY (Hospital_ID)
);


CREATE TABLE Departments(
	Department_ID varchar2(10) NOT NULL,
	Department_Name varchar2(50) NOT NULL,
	Service_Name varchar2(50) NULL,
	Hospital_ID varchar2(10),
 CONSTRAINT PK_Departments PRIMARY KEY (Department_ID),
 CONSTRAINT FK_Departments_Hospitals FOREIGN KEY(Hospital_ID) REFERENCES Hospitals(Hospital_ID)
);


CREATE TABLE Staff(
	Staff_ID varchar2(10) NOT NULL,
	Staff_Name varchar2(50) NOT NULL,
	Staff_Contact varchar2(25) NOT NULL,
	Staff_Email varchar2(100) NOT NULL,
	Department_ID varchar2(10) NOT NULL,
 CONSTRAINT PK_Staff PRIMARY KEY (Staff_ID),
 CONSTRAINT FK_Staff_Departments FOREIGN KEY(Department_ID) REFERENCES Departments (Department_ID)
);


CREATE TABLE Bed(
	Bed_ID varchar2(10) NOT NULL,
	Bed_No varchar2(10) NOT NULL,
 CONSTRAINT PK_Bed PRIMARY KEY (Bed_ID)
);


CREATE TABLE Medication(
	Medication_ID number(10,0) NOT NULL,
	Medication_Name varchar2(50) NOT NULL,
	Medication_Brand varchar2(50) NOT NULL,
	Medication_Description varchar2(150) NULL,
 CONSTRAINT PK_Medication PRIMARY KEY (Medication_ID)
);


CREATE TABLE Patient(
	Patient_ID number(10,0) NOT NULL,
	Patient_Name varchar2(50) NOT NULL,
	Patient_Gender char(1) NOT NULL,
	Patient_Birth_Date date NOT NULL,
	Patient_Phone varchar2(25) NOT NULL,
	Patient_Address varchar2(250) NULL,
	Patient_Type varchar2(50) NOT NULL,
 CONSTRAINT PK_Patient PRIMARY KEY (Patient_ID)
);


CREATE TABLE Out_Patient(
	Patient_ID number(10,0) NOT NULL,
	Checkback_Date date NOT NULL,
 CONSTRAINT PK_OutPatient PRIMARY KEY (Patient_ID,Checkback_Date),
 CONSTRAINT FK_OutPatient_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID)
);


CREATE TABLE Resident_Patient(
	Patient_ID number(10,0) NOT NULL,
	Date_Discharged date NOT NULL,
 CONSTRAINT PK_ResidentPatient PRIMARY KEY (Patient_ID,Date_Discharged),
 CONSTRAINT FK_ResidentPatient_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID)
);


CREATE TABLE Physician(
	Physician_ID number(10,0) NOT NULL,
	Physician_Name varchar2(50) NOT NULL,
	Physician_Contact varchar2(25) NOT NULL,
	Physician_Email varchar2(100) NOT NULL,
	Department_ID varchar2(10)  NOT NULL,
 CONSTRAINT PK_Physician PRIMARY KEY (Physician_ID),
 CONSTRAINT FK_Physician_Departments FOREIGN KEY (Department_ID) REFERENCES Departments (Department_ID)
);



CREATE TABLE Admissions(
	Admission_ID number(10,0) NOT NULL,
	Patient_ID number(10,0) NOT NULL,
	Admission_Date date NOT NULL,
	Discharge_Date date NULL,
	Bed_ID varchar2(10) NOT NULL,
	Department_ID varchar2(10) NOT NULL,
 CONSTRAINT PK_Admissions PRIMARY KEY (Admission_ID),
 CONSTRAINT FK_Admissions_Bed FOREIGN KEY(Bed_ID) REFERENCES Bed (Bed_ID),
 CONSTRAINT FK_Admissions_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID),
 CONSTRAINT FK_Admissions_Departments FOREIGN KEY(Department_ID) REFERENCES Departments (Department_ID)
);


CREATE TABLE Appointment(
	Appointment_ID number(10,0) NOT NULL,
	Patient_ID number(10,0) NOT NULL,
	Physician_ID number(10,0) NOT NULL,
	Start_DT timestamp NOT NULL,
	End_DT timestamp NULL,
	Room_ID number(10,0) NOT NULL,
 CONSTRAINT PK_Appointment PRIMARY KEY (Appointment_ID),
 CONSTRAINT FK_Appointment_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID),
 CONSTRAINT FK_Appointment_Physician FOREIGN KEY(Physician_ID) REFERENCES Physician (Physician_ID)
);


CREATE TABLE Patient_Medication(
	Patient_Medication_ID number(10,0) NOT NULL,
	Patient_ID number(10,0)  NOT NULL,
	Physician_ID number(10,0)  NOT NULL,
	Medication_ID number(10,0)  NOT NULL,
	Patient_Prescription varchar2(100) NOT NULL,
	Does varchar2(50) NOT NULL,
 CONSTRAINT PK_PatientMedication PRIMARY KEY (Patient_Medication_ID),
 CONSTRAINT FK_PatientMedication_Medication FOREIGN KEY(Medication_ID) REFERENCES Medication (Medication_ID),
 CONSTRAINT FK_PatientMedication_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID),
 CONSTRAINT FK_PatientMedication_Physician FOREIGN KEY(Physician_ID) REFERENCES Physician (Physician_ID)
);


CREATE TABLE Lab_Work(
	Lab_ID varchar2(10) NOT NULL,
	Test_Type varchar2(50) NOT NULL,
	Physician_ID number(10,0) NOT NULL,
	Patient_ID number(10,0) NOT NULL,
	Lab_Date date NOT NULL,
	Lab_Result varchar2(50) NULL,
	Result_Date date NULL,
 CONSTRAINT PK_LabWork PRIMARY KEY (Lab_ID),
 CONSTRAINT FK_LabWork_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID),
 CONSTRAINT FK_LabWork_Physician FOREIGN KEY(Physician_ID) REFERENCES Physician (Physician_ID)
);


CREATE TABLE Patient_Treatment(
	Treatment_ID number(10,0) NOT NULL,
	Patient_ID number(10,0)  NULL,
	Physician_ID number(10,0)  NULL,
	Lab_ID varchar2(10) NOT NULL,
	Treatment_Date date NULL,
	Treatment_Time timestamp NULL,
	Treatment_Results varchar2(100) NULL,
 CONSTRAINT PK_Treatment PRIMARY KEY (Treatment_ID),
 CONSTRAINT FK_PatientTreatment_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID),
 CONSTRAINT FK_PatientTreatment_Physician FOREIGN KEY(Physician_ID) REFERENCES Physician (Physician_ID),
 CONSTRAINT FK_PatientTreatment_LabWork FOREIGN KEY(Lab_ID) REFERENCES Lab_Work (Lab_ID)
);


CREATE TABLE Payments(
	Payment_ID number(10,0) NOT NULL,
	Payment_Date date NOT NULL,
	Payment_Details varchar2(50) NOT NULL,
	Patient_ID number(10,0) NOT NULL,
	Payment_Type varchar2(50) NOT NULL,
	Payment_Amount number(10,2) NOT NULL,
 CONSTRAINT PK_Payments PRIMARY KEY (Payment_ID),
 CONSTRAINT FK_Payments_Patient FOREIGN KEY(Patient_ID) REFERENCES Patient (Patient_ID)
);