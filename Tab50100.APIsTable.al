table 50100 "APIs Table"
{
    Caption = 'APIs Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; Id; Guid)
        {
            Caption = 'Id';
        }
        field(2; Name; Text[200])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Id:=CreateGuid();
    end;
}


