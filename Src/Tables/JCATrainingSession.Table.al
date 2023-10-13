table 50105 "JCA Training Session"
{
    Caption ='Training Session';

    fields
    {
        field(1;ID;Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2;Date;Date)
        {
            Caption ='Date';
            DataClassification = SystemMetadata;            
        }
        field(3;"Training Group Code";Code[20])
        {
            Caption ='Training Group Code';
            DataClassification = SystemMetadata;
            TableRelation = "JCA Training Group".Code;
        }
    }
}