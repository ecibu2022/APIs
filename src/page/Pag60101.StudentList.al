page 60101 "Student List"
{
    ApplicationArea = All;
    Caption = 'Student List';
    PageType = List;
    SourceTable = Student;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("e-Mail"; Rec."e-Mail")
                {
                    ToolTip = 'Specifies the value of the e-Mail field.', Comment = '%';
                }
                field(Website; Rec.Website)
                {
                    ToolTip = 'Specifies the value of the Website field.', Comment = '%';
                }
                field(Latitude; Rec.Latitude)
                {
                    ToolTip = 'Specifies the value of the Latitude field.', Comment = '%';
                }
                field(Longitude; Rec.Longitude)
                {
                    ToolTip = 'Specifies the value of the Longitude field.', Comment = '%';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.', Comment = '%';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = '%';
                }
                field("Web ID"; Rec."Web ID")
                {
                    ToolTip = 'Specifies the value of the Web ID field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Students Information")
            {
                ApplicationArea = All;
                Image=Import;
                Promoted=true;
                PromotedCategory=Process;
                
                trigger OnAction()
                var
                    HttpClient: HttpClient;
                    HttResponseMeassage: HttpResponseMessage;
                    Response: Text;
                begin
                    // Get method allows you to send a request for a service
                    if HttpClient.Get('https://jsonplaceholder.typicode.com/users', HttResponseMeassage) then begin
                        // Reading the data in the response
                        HttResponseMeassage.Content.ReadAs(Response);
                        "Read Result Response"(Response);
                    end;
                end;
            }
        }
    }

    local procedure "Read Result Response"(Response: Text)
    var
        // []
        JSONArray: JsonArray;
        // {}
        JSONObject: JsonObject;
        JSONValue: JsonValue;
        i: Integer;
        RecStudent: Record Student;
        StudentID: Integer;
        JSONToken: JsonToken;
        ValueJSONToken: JsonToken;
    begin
        RecStudent.Reset();
        if RecStudent.FindLast() then
            StudentID := RecStudent.ID + 1
        else
            StudentID := 1;

        // Read data as json token
        if JSONToken.ReadFrom(Response) then begin
            if JSONToken.IsArray then begin
                // Coverting JSONToken to JSONArray
                JSONArray := JSONToken.AsArray();
                // Reading the response in the array
                for i := 0 to JSONArray.Count - 1 do begin
                    JSONArray.Get(i, JSONToken);

                    if JSONToken.IsObject then begin
                        JSONObject := JSONToken.AsObject();

                        RecStudent.Reset();
                        RecStudent.Init();
                        RecStudent.ID := StudentID;

                        if JSONObject.Get('id', ValueJSONToken) then begin
                            if ValueJSONToken.IsValue then begin
                                RecStudent."Web ID" := ValueJSONToken.AsValue().AsInteger();
                            end;
                        end;

                        if "Get Result JSON Value"(JSONObject, 'name', JSONValue) then
                            RecStudent.Name := JSONValue.AsText();
                        if "Get Result JSON Value"(JSONObject, 'email', JSONValue) then
                            RecStudent."e-Mail" := JSONValue.AsText();
                        if "Get Result JSON Value"(JSONObject, 'phone', JSONValue) then
                            RecStudent."Phone No." := JSONValue.AsText();
                        if "Get Result JSON Value"(JSONObject, 'website', JSONValue) then
                            RecStudent.Website := JSONValue.AsText();

                        // Read level 2 values ie multi dimension array
                        if JSONObject.Get('address', JSONToken) then begin
                            if JSONToken.IsObject then begin
                                // Covert JsonToken to JsonArray
                                JSONObject := JSONToken.AsObject();
                                if "Get Result JSON Value"(JSONObject, 'city', JSONValue) then
                                    RecStudent.City := JSONValue.AsText();

                                // Read level 2.1 values ie multi dimension array geo
                                if JSONObject.Get('geo', JSONToken) then begin
                                    if JSONToken.IsObject then begin
                                        // Covert JsonToken to JsonArray
                                        JSONObject := JSONToken.AsObject();
                                        if "Get Result JSON Value"(JSONObject, 'lat', JSONValue) then
                                            RecStudent.Latitude := JSONValue.AsDecimal();
                                        if "Get Result JSON Value"(JSONObject, 'lng', JSONValue) then
                                            RecStudent.Longitude := JSONValue.AsDecimal();
                                    end;
                                end;    
                            end;
                        end;

                        RecStudent.Active := true;
                        RecStudent.Insert();
                        StudentID += 1;

                    end;
                end;
            end;
        end;
    end;

    local procedure "Get Result JSON Value"(JObject: JsonObject; KeyName: Text; var JValue: JsonValue): Boolean
    var
        JToken: JsonToken;
    begin
        if not JObject.Get(KeyName, JToken) then exit;
        JValue:=JToken.AsValue();
        exit(true);
    end;
}