table 60101 Student
{
    Caption = 'Student';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement=true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(4; "e-Mail"; Text[250])
        {
            Caption = 'e-Mail';
            DataClassification = ToBeClassified;
            ExtendedDatatype=EMail;
        }
        field(5; Website; Text[250])
        {
            Caption = 'Website';
            DataClassification = ToBeClassified;
            ExtendedDatatype=URL;
        }
        field(6; Latitude; Decimal)
        {
            Caption = 'Latitude';
            DataClassification = ToBeClassified;
        }
        field(7; Longitude; Decimal)
        {
            Caption = 'Longitude';
            DataClassification = ToBeClassified;
        }
        field(8; City; Text[100])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(9; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
        field(10; "Web ID"; Integer)
        {
            Caption = 'Web ID';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
